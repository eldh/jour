module Values = {
  let string_of_float = Js.Float.toString
  let string_of_int = Js.Int.toString

  external float_cast: float => string = "%identity"
  external int_cast: int => string = "%identity"
  external size_cast: ReactNative.Style.size => string = "%identity"
  external bool_cast: bool => string = "%identity"
  external style_cast: ReactNative.Style.t => Js.Dict.t<string> = "%identity"

  let rec string_of_length = x =>
    switch x {
    | #calc(#add, a, b) =>
      "calc(" ++ (string_of_length(a) ++ (" + " ++ (string_of_length(b) ++ ")")))
    | #calc(#sub, a, b) =>
      "calc(" ++ (string_of_length(a) ++ (" - " ++ (string_of_length(b) ++ ")")))
    | #ch(x) => string_of_float(x) ++ "ch"
    | #cm(x) => string_of_float(x) ++ "cm"
    | #em(x) => string_of_float(x) ++ "em"
    | #ex(x) => string_of_float(x) ++ "ex"
    | #mm(x) => string_of_float(x) ++ "mm"
    | #percent(x) => string_of_float(x) ++ "%"
    | #pt(x) => string_of_int(x) ++ "pt"
    | #px(x) => string_of_int(x) ++ "px"
    | #rem(x) => string_of_float(x) ++ "rem"
    | #vh(x) => string_of_float(x) ++ "vh"
    | #vmax(x) => string_of_float(x) ++ "vmax"
    | #vmin(x) => string_of_float(x) ++ "vmin"
    | #vw(x) => string_of_float(x) ++ "vw"
    | #zero => "0"
    }

  let string_of_rgb = (r, g, b) =>
    "rgb(" ++
    (string_of_int(r) ++
    (", " ++ (string_of_int(g) ++ (", " ++ (string_of_int(b) ++ ")")))))

  let string_of_rgba = (r, g, b, a) =>
    a === 1.
      ? string_of_rgb(r, g, b)
      : "rgba(" ++
        (string_of_int(r) ++
        (", " ++
        (string_of_int(g) ++
        (", " ++ (string_of_int(b) ++ (", " ++ (string_of_float(a) ++ ")")))))))

  let string_of_p3 = (r, g, b, a) =>
    "color(display-p3 " ++
    (string_of_float(r) ++
    (" " ++
    (string_of_float(g) ++
    (" " ++ (string_of_float(b) ++ (a === 1. ? ")" : " / " ++ (string_of_float(a) ++ ")")))))))
  let string_of_color = (~highlight as _=?, ~tint as _=?, c) =>
    switch c {
    | #p3(r, g, b, a) => string_of_p3(r, g, b, a)
    | #rgb(r, g, b) => string_of_rgb(r, g, b)
    | #rgba(r, g, b, a) => string_of_rgba(r, g, b, a)
    | #transparent => "transparent"
    }
  let string_of_size = x =>
    switch x {
    | #px(v) => v->int_cast
    | #n(v: int) => Core.Styles.getSpace(#number(v))->size_cast // Dangerous?
    | #pct(v) => v->string_of_int ++ "%"
    | #auto => "auto"
    }

  let size = string_of_size
  let space = size_cast
  let color = string_of_color
  let dp = v => v |> ReactNative.Style.dp |> space
  let bool = bool_cast
  type offset
  @obj external _offset: (~height: float, ~width: float) => offset = ""
  external offset_cast: offset => string = "%identity"
  let offset = (~width, ~height) => _offset(~width, ~height) |> offset_cast
}
external toReactNativeStyle: {.} => ReactNative.Style.t = "%identity"
external dict_to_obj: Js.Dict.t<string> => {.} = "%identity"
external castDictList: list<(string, 'a)> => list<(Js.Dict.key, 'a)> = "%identity"
external castDictPair: ((string, 'a)) => (Js.Dict.key, 'a) = "%identity"
let l = v => Some(v->castDictList->Js.Dict.fromList)
let o = (k, v) => {
  let obj = Js.Dict.empty()
  Js.Dict.set(obj, k, v)
  Some(obj)
}
let op = (k, fn, v) =>
  switch v {
  | Some(s) =>
    let obj = Js.Dict.empty()
    Js.Dict.set(obj, k, fn(s))
    Some(obj)
  | None => None
  }

/*
 ~fontStyle: [@bs.string] [ | `normal | `italic]=?,
 ~fontVariant: array(FontVariant.t)=?,
 ~textAlign: [@bs.string] [ | `auto | `left | `right | `center | `justify]=?,
 ~textAlignVertical: [@bs.string] [ | `auto | `top | `bottom | `center]=?,
 ~textDecorationLine: [@bs.string] [
                        | `none
                        | `underline
                        | [@bs.as "line-through"] `lineThrough
                        | [@bs.as "underline line-through"]
                          `underlineLineThrough
                      ]
                        =?,
 ~textDecorationStyle: [@bs.string] [
                         | `solid
                         | `double
                         | `dotted
                         | `dashed
                       ]
                         =?,
 ~textShadowOffset: offset=?,
 ~textTransform: [@bs.string] [
                   | `none
                   | `uppercase
                   | `lowercase
                   | `capitalize
                 ]
                   =?,
 ~writingDirection: [@bs.string] [ | `auto | `ltr | `rtl]=?,
 // View styles https://facebook.github.io/react-native/docs/view-style-props
 ~backfaceVisibility: [@bs.string] [ | `visible | `hidden]=?,
 ~transform: array(transform)=?, // all other transform props are deprecated
 */
open Core.Styles
let shadowOffset = ((width, height)) => o("shadowOffset", Values.offset(~width, ~height))
let fontWeight = v =>
  o(
    "fontWeight",
    switch v {
    | #normal => "normal"
    | #bold => "bold"
    | #_100 => "100"
    | #_200 => "200"
    | #_300 => "300"
    | #_400 => "400"
    | #_500 => "500"
    | #_600 => "600"
    | #_700 => "700"
    | #_800 => "800"
    | #_900 => "900"
    },
  )
let includeFontPadding = v => o("includeFontPadding", v |> Values.bool)
let letterSpacing = v => o("letterSpacing", v |> Values.dp)
let lineHeight = v => o("lineHeight", v |> Values.dp)
let textShadowRadius = v => o("textShadowRadius", v |> Values.dp)
let textDecorationColor = v =>
  o("textDecorationColor", v |> (v => getColor(v)) |> (v => Values.color(v)))
let textShadowColor = v => o("textShadowColor", v |> (v => getColor(v)) |> (v => Values.color(v)))
let borderBottomColor = v =>
  o("borderBottomColor", v |> (v => getColor(v)) |> (v => Values.color(v)))
let borderColor = v => o("borderColor", v |> (v => getColor(v)) |> (v => Values.color(v)))
let borderEndColor = v => o("borderEndColor", v |> (v => getColor(v)) |> (v => Values.color(v)))
let borderLeftColor = v => o("borderLeftColor", v |> (v => getColor(v)) |> (v => Values.color(v)))
let borderRightColor = v => o("borderRightColor", v |> (v => getColor(v)) |> (v => Values.color(v)))
let borderStartColor = v => o("borderStartColor", v |> (v => getColor(v)) |> (v => Values.color(v)))
let borderTopColor = v => o("borderTopColor", v |> (v => getColor(v)) |> (v => Values.color(v)))
let borderStyle = v =>
  o(
    "borderStyle",
    switch v {
    | #solid => "solid"
    | #dotted => "dotted"
    | #dashed => "dashed"
    },
  )
let shadowColor = v => o("shadowColor", v |> (v => getColor(v)) |> (v => Values.color(v)))
let shadowOpacity = v => o("shadowOpacity", v |> Values.float_cast)
let shadowRadius = v => o("shadowRadius", v |> Values.dp)
let borderBottomEndRadius = v => o("borderBottomEndRadius", v |> Values.dp)
let borderBottomLeftRadius = v => o("borderBottomLeftRadius", v |> Values.dp)
let borderBottomRightRadius = v => o("borderBottomRightRadius", v |> Values.dp)
let borderBottomStartRadius = v => o("borderBottomStartRadius", v |> Values.dp)
let borderTopEndRadius = v => o("borderTopEndRadius", v |> Values.dp)
let borderTopLeftRadius = v => o("borderTopLeftRadius", v |> Values.dp)
let borderTopRightRadius = v => o("borderTopRightRadius", v |> Values.dp)
let borderTopStartRadius = v => o("borderTopStartRadius", v |> Values.dp)
let elevation = v => o("elevation", v |> Values.float_cast)

let resizeMode = v => ReactNative.Style.style(~resizeMode=v, ()) |> Values.style_cast
let fontFamily = v => o("fontFamily", getFontFamily(v))
let direction = v =>
  o(
    "direction",
    switch v {
    | #inherit_ => "inherit"
    | #ltr => "ltr"
    | #rtl => "rtl"
    },
  )
let display = v =>
  o(
    "display",
    switch v {
    | #none => "none"
    | #flex => "flex"
    },
  )

let zIndex = v => o("zIndex", v |> Values.int_cast)
let borderWidth = v => o("borderWidth", v |> Values.dp)
let opacity = v => o("opacity", v |> Values.float_cast)
let aspectRatio = v => o("aspectRatio", v |> Values.float_cast)
let fontSize = v => o("fontSize", v |> getFontSize |> float_of_int |> Values.dp)
let borderEndWidth = v => o("borderEndWidth", v |> Values.dp)
let borderStartWidth = v => o("borderStartWidth", v |> Values.dp)
let borderRightWidth = v => o("borderRightWidth", v |> Values.dp)
let borderTopWidth = v => o("borderTopWidth", v |> Values.dp)
let borderLeftWidth = v => o("borderLeftWidth", v |> Values.dp)
let borderBottomWidth = v => o("borderBottomWidth", v |> Values.dp)
let flexDirection = v =>
  o(
    "flexDirection",
    switch v {
    | #row => "row"
    | #rowReverse => "rowReverse"
    | #column => "column"
    | #columnReverse => "columnReverse"
    },
  )
let flex = v => o("flex", v |> Values.float_cast)
let flexShrink = v => o("flexShrink", v |> Values.float_cast)
let flexGrow = v => o("flexGrow", v |> Values.float_cast)
let flexWrap = v =>
  o(
    "flexWrap",
    switch v {
    | #wrap => "wrap"
    | #nowrap => "wrap"
    },
  )
let justifyContent = v =>
  o(
    "justifyContent",
    switch v {
    | #flexStart => "flex-start"
    | #flexEnd => "flex-end"
    | #center => "center"
    | #spaceAround => "space-around"
    | #spaceBetween => "space-between"
    | #spaceEvenly => "space-evenly"
    },
  )
let alignContent = v =>
  o(
    "alignContent",
    switch v {
    | #spaceAround => "space-around"
    | #spaceBetween => "space-between"
    | #center => "center"
    | #stretch => "stretch"
    | #flexStart => "flex-start"
    | #flexEnd => "flex-end"
    },
  )
let alignItems = v =>
  o(
    "alignItems",
    switch v {
    | #center => "center"
    | #stretch => "stretch"
    | #baseline => "baseline"
    | #flexStart => "flex-start"
    | #flexEnd => "flex-end"
    },
  )
let alignSelf = v =>
  o(
    "alignSelf",
    switch v {
    | #auto => "auto"
    | #center => "center"
    | #stretch => "stretch"
    | #baseline => "baseline"
    | #flexStart => "flex-start"
    | #flexEnd => "flex-end"
    },
  )
let width = v => o("width", v |> Values.size)
let flexBasis = v => o("flexBasis", v |> Values.size)
let height = v => o("height", v |> Values.size)
let minHeight = v => o("minHeight", v |> Values.size)
let minWidth = v => o("minWidth", v |> Values.size)
let maxHeight = v => o("maxHeight", v |> Values.size)
let maxWidth = v => o("maxWidth", v |> Values.size)
let top = v => o("top", v |> (v => getSpace(v)) |> Values.space)
let left = v => o("left", v |> (v => getSpace(v)) |> Values.space)
let bottom = v => o("bottom", v |> (v => getSpace(v)) |> Values.space)
let right = v => o("right", v |> (v => getSpace(v)) |> Values.space)
let start = v => o("start", v |> (v => getSpace(v)) |> Values.space)
let end_ = v => o("end", v |> (v => getSpace(v)) |> Values.space)
let overflow = v =>
  o(
    "overflow",
    switch v {
    | #visible => "visible"
    | #hidden => "hidden"
    | #scroll => "scroll"
    },
  )
let position = v =>
  o(
    "position",
    switch v {
    | #absolute => "absolute"
    | #relative => "relative"
    },
  )
let padding2 = (v, h) =>
  l(list{
    ("paddingHorizontal", h |> (v => getSpace(v)) |> Values.space),
    ("paddingVertical", v |> (v => getSpace(v)) |> Values.space),
  })
let padding4 = (l_, t, r, b) =>
  l(list{
    ("paddingLeft", l_ |> (v => getSpace(v)) |> Values.space),
    ("paddingTop", t |> (v => getSpace(v)) |> Values.space),
    ("paddingBottom", b |> (v => getSpace(v)) |> Values.space),
    ("paddingRight", r |> (v => getSpace(v)) |> Values.space),
  })
let padding = v => op("padding", s => s |> (v => getSpace(v)) |> Values.space, v)
let paddingTop = v => o("paddingTop", v |> (v => getSpace(v)) |> Values.space)
let paddingBottom = v => o("paddingBottom", v |> (v => getSpace(v)) |> Values.space)
let paddingLeft = v => o("paddingLeft", v |> (v => getSpace(v)) |> Values.space)
let paddingRight = v => o("paddingRight", v |> (v => getSpace(v)) |> Values.space)
let margin2 = (v, h) =>
  l(list{
    ("marginVertical", v |> (v => getSpace(v)) |> Values.space),
    ("marginHorizontal", h |> (v => getSpace(v)) |> Values.space),
  })
let margin4 = (l_, t, r, b) =>
  l(list{
    ("marginLeft", l_ |> (v => getSpace(v)) |> Values.space),
    ("marginTop", t |> (v => getSpace(v)) |> Values.space),
    ("marginBottom", b |> (v => getSpace(v)) |> Values.space),
    ("marginRight", r |> (v => getSpace(v)) |> Values.space),
  })
let margin = v => op("margin", s => s |> (v => getSpace(v)) |> Values.space, v)
let marginTop = v => o("marginTop", v |> (v => getSpace(v)) |> Values.space)
let marginBottom = v => o("marginBottom", v |> (v => getSpace(v)) |> Values.space)
let marginLeft = v => o("marginLeft", v |> (v => getSpace(v)) |> Values.space)
let marginRight = v => o("marginRight", v |> (v => getSpace(v)) |> Values.space)
let backgroundColor = v => o("backgroundColor", getColor(v) |> (v => Values.color(v)))
let overlayColor = v => o("overlayColor", getColor(v) |> (v => Values.color(v)))
let tintColor = v => o("tintColor", getColor(v) |> (v => Values.color(v)))
let borderRadius = v => o("borderRadius", v |> getBorderRadius |> Values.int_cast)
let color = (~highlight=?, ~tint as _=?, v) => {
  let res = o("color", v |> getTextColor(~highlight?) |> (v => Values.color(v)))
  Js.log2("res", res)
  res
}

let make = styleList => styleList |> List.fold_left((obj, el) =>
    switch el {
    | Some(e) => e |> dict_to_obj |> Js.Obj.assign(obj)
    | None => obj
    }
  , Js.Obj.empty()) |> toReactNativeStyle
// let value = rule => {
//   rule->Obj.magic->Log.pass("rule")
// }
external fromReactNativeStyle: ReactNative.Style.t => {.} = "%identity"
let merge = (a: ReactNative.Style.t, b: ReactNative.Style.t) =>
  {
    open Js.Obj
    empty() |> assign(b |> fromReactNativeStyle) |> assign(a |> fromReactNativeStyle)
  } |> toReactNativeStyle
