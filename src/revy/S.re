module Values = {
  let string_of_float = Js.Float.toString;
  let string_of_int = Js.Int.toString;

  external float_cast: float => string = "%identity";
  external int_cast: int => string = "%identity";
  external size_cast: ReactNative.Style.size => string = "%identity";
  external bool_cast: bool => string = "%identity";
  external style_cast: ReactNative.Style.t => Js.Dict.t(string) = "%identity";

  let rec string_of_length =
    fun
    | `calc(`add, a, b) =>
      "calc(" ++ string_of_length(a) ++ " + " ++ string_of_length(b) ++ ")"
    | `calc(`sub, a, b) =>
      "calc(" ++ string_of_length(a) ++ " - " ++ string_of_length(b) ++ ")"
    | `ch(x) => string_of_float(x) ++ "ch"
    | `cm(x) => string_of_float(x) ++ "cm"
    | `em(x) => string_of_float(x) ++ "em"
    | `ex(x) => string_of_float(x) ++ "ex"
    | `mm(x) => string_of_float(x) ++ "mm"
    | `percent(x) => string_of_float(x) ++ "%"
    | `pt(x) => string_of_int(x) ++ "pt"
    | `px(x) => string_of_int(x) ++ "px"
    | `rem(x) => string_of_float(x) ++ "rem"
    | `vh(x) => string_of_float(x) ++ "vh"
    | `vmax(x) => string_of_float(x) ++ "vmax"
    | `vmin(x) => string_of_float(x) ++ "vmin"
    | `vw(x) => string_of_float(x) ++ "vw"
    | `zero => "0";

  let string_of_rgb = (r, g, b) =>
    "rgb("
    ++ string_of_int(r)
    ++ ", "
    ++ string_of_int(g)
    ++ ", "
    ++ string_of_int(b)
    ++ ")";

  let string_of_rgba = (r, g, b, a) =>
    a === 1.
      ? string_of_rgb(r, g, b)
      : "rgba("
        ++ string_of_int(r)
        ++ ", "
        ++ string_of_int(g)
        ++ ", "
        ++ string_of_int(b)
        ++ ", "
        ++ string_of_float(a)
        ++ ")";

  let string_of_p3 = (r, g, b, a) =>
    "color(display-p3 "
    ++ string_of_float(r)
    ++ " "
    ++ string_of_float(g)
    ++ " "
    ++ string_of_float(b)
    ++ (a === 1. ? ")" : " / " ++ string_of_float(a) ++ ")");
  let string_of_color = (~highlight=?, ~tint=?, c) =>
    switch (c) {
    | `p3(r, g, b, a) => string_of_p3(r, g, b, a)
    | `rgb(r, g, b) => string_of_rgb(r, g, b)
    | `rgba(r, g, b, a) => string_of_rgba(r, g, b, a)
    | `transparent => "transparent"
    };
  let string_of_size =
    fun
    | `px(v) => v->int_cast
    | `n((v: int)) => Core.Styles.getSpace(`number(v))->size_cast // Dangerous?
    | `pct(v) => v->string_of_int ++ "%"
    | `auto => "auto";

  let size = string_of_size;
  let space = size_cast;
  let color = string_of_color;
  let dp = v => v |> ReactNative.Style.dp |> space;
  let bool = bool_cast;
  type offset;
  [@bs.obj] external _offset: (~height: float, ~width: float) => offset;
  external offset_cast: offset => string = "%identity";
  let offset = (~width, ~height) => _offset(~width, ~height) |> offset_cast;
};
external toReactNativeStyle: Js.t({.}) => ReactNative.Style.t = "%identity";
external dict_to_obj: Js.Dict.t(string) => Js.t({.}) = "%identity";
external castDictList: list((string, 'a)) => list((Js.Dict.key, 'a)) =
  "%identity";
external castDictPair: ((string, 'a)) => (Js.Dict.key, 'a) = "%identity";
let l = v => Some(v->castDictList->Js.Dict.fromList);
let o = (k, v) => {
  let obj = Js.Dict.empty();
  Js.Dict.set(obj, k, v);
  Some(obj);
};
let op = (k, fn, v) => {
  switch (v) {
  | Some(s) =>
    let obj = Js.Dict.empty();
    Js.Dict.set(obj, k, fn(s));
    Some(obj);
  | None => None
  };
};

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
open Core.Styles;
let shadowOffset = ((width, height)) =>
  o("shadowOffset", Values.offset(~width, ~height));
let fontWeight = v =>
  o(
    "fontWeight",
    switch (v) {
    | `normal => "normal"
    | `bold => "bold"
    | `_100 => "100"
    | `_200 => "200"
    | `_300 => "300"
    | `_400 => "400"
    | `_500 => "500"
    | `_600 => "600"
    | `_700 => "700"
    | `_800 => "800"
    | `_900 => "900"
    },
  );
let includeFontPadding = v => o("includeFontPadding", v |> Values.bool);
let letterSpacing = v => o("letterSpacing", v |> Values.dp);
let lineHeight = v => o("lineHeight", v |> Values.dp);
let textShadowRadius = v => o("textShadowRadius", v |> Values.dp);
let textDecorationColor = v =>
  o("textDecorationColor", v |> getColor |> Values.color);
let textShadowColor = v =>
  o("textShadowColor", v |> getColor |> Values.color);
let borderBottomColor = v =>
  o("borderBottomColor", v |> getColor |> Values.color);
let borderColor = v => o("borderColor", v |> getColor |> Values.color);
let borderEndColor = v => o("borderEndColor", v |> getColor |> Values.color);
let borderLeftColor = v =>
  o("borderLeftColor", v |> getColor |> Values.color);
let borderRightColor = v =>
  o("borderRightColor", v |> getColor |> Values.color);
let borderStartColor = v =>
  o("borderStartColor", v |> getColor |> Values.color);
let borderTopColor = v => o("borderTopColor", v |> getColor |> Values.color);
let borderStyle = v =>
  o(
    "borderStyle",
    switch (v) {
    | `solid => "solid"
    | `dotted => "dotted"
    | `dashed => "dashed"
    },
  );
let shadowColor = v => o("shadowColor", v |> getColor |> Values.color);
let shadowOpacity = v => o("shadowOpacity", v |> Values.float_cast);
let shadowRadius = v => o("shadowRadius", v |> Values.dp);
let borderBottomEndRadius = v => o("borderBottomEndRadius", v |> Values.dp);
let borderBottomLeftRadius = v => o("borderBottomLeftRadius", v |> Values.dp);
let borderBottomRightRadius = v =>
  o("borderBottomRightRadius", v |> Values.dp);
let borderBottomStartRadius = v =>
  o("borderBottomStartRadius", v |> Values.dp);
let borderTopEndRadius = v => o("borderTopEndRadius", v |> Values.dp);
let borderTopLeftRadius = v => o("borderTopLeftRadius", v |> Values.dp);
let borderTopRightRadius = v => o("borderTopRightRadius", v |> Values.dp);
let borderTopStartRadius = v => o("borderTopStartRadius", v |> Values.dp);
let elevation = v => o("elevation", v |> Values.float_cast);

let resizeMode = v =>
  ReactNative.Style.style(~resizeMode=v, ()) |> Values.style_cast;
let fontFamily = v => o("fontFamily", getFontFamily(v));
let direction = v =>
  o(
    "direction",
    switch (v) {
    | `inherit_ => "inherit"
    | `ltr => "ltr"
    | `rtl => "rtl"
    },
  );
let display = v =>
  o(
    "display",
    switch (v) {
    | `none => "none"
    | `flex => "flex"
    },
  );

let zIndex = v => o("zIndex", v |> Values.int_cast);
let borderWidth = v => o("borderWidth", v |> Values.dp);
let opacity = v => o("opacity", v |> Values.float_cast);
let aspectRatio = v => o("aspectRatio", v |> Values.float_cast);
let fontSize = v =>
  o("fontSize", v |> getFontSize |> float_of_int |> Values.dp);
let borderEndWidth = v => o("borderEndWidth", v |> Values.dp);
let borderStartWidth = v => o("borderStartWidth", v |> Values.dp);
let borderRightWidth = v => o("borderRightWidth", v |> Values.dp);
let borderTopWidth = v => o("borderTopWidth", v |> Values.dp);
let borderLeftWidth = v => o("borderLeftWidth", v |> Values.dp);
let borderBottomWidth = v => o("borderBottomWidth", v |> Values.dp);
let flexDirection = v =>
  o(
    "flexDirection",
    switch (v) {
    | `row => "row"
    | `rowReverse => "rowReverse"
    | `column => "column"
    | `columnReverse => "columnReverse"
    },
  );
let flex = v => o("flex", v |> Values.float_cast);
let flexShrink = v => o("flexShrink", v |> Values.float_cast);
let flexGrow = v => o("flexGrow", v |> Values.float_cast);
let flexWrap = v =>
  o(
    "flexWrap",
    switch (v) {
    | `wrap => "wrap"
    | `nowrap => "wrap"
    },
  );
let justifyContent = v =>
  o(
    "justifyContent",
    switch (v) {
    | `flexStart => "flex-start"
    | `flexEnd => "flex-end"
    | `center => "center"
    | `spaceAround => "space-around"
    | `spaceBetween => "space-between"
    | `spaceEvenly => "space-evenly"
    },
  );
let alignContent = v =>
  o(
    "alignContent",
    switch (v) {
    | `spaceAround => "space-around"
    | `spaceBetween => "space-between"
    | `center => "center"
    | `stretch => "stretch"
    | `flexStart => "flex-start"
    | `flexEnd => "flex-end"
    },
  );
let alignItems = v =>
  o(
    "alignItems",
    switch (v) {
    | `center => "center"
    | `stretch => "stretch"
    | `baseline => "baseline"
    | `flexStart => "flex-start"
    | `flexEnd => "flex-end"
    },
  );
let alignSelf = v =>
  o(
    "alignSelf",
    switch (v) {
    | `auto => "auto"
    | `center => "center"
    | `stretch => "stretch"
    | `baseline => "baseline"
    | `flexStart => "flex-start"
    | `flexEnd => "flex-end"
    },
  );
let width = v => o("width", v |> Values.size);
let flexBasis = v => o("flexBasis", v |> Values.size);
let height = v => o("height", v |> Values.size);
let minHeight = v => o("minHeight", v |> Values.size);
let minWidth = v => o("minWidth", v |> Values.size);
let maxHeight = v => o("maxHeight", v |> Values.size);
let maxWidth = v => o("maxWidth", v |> Values.size);
let top = v => o("top", v |> getSpace |> Values.space);
let left = v => o("left", v |> getSpace |> Values.space);
let bottom = v => o("bottom", v |> getSpace |> Values.space);
let right = v => o("right", v |> getSpace |> Values.space);
let start = v => o("start", v |> getSpace |> Values.space);
let end_ = v => o("end", v |> getSpace |> Values.space);
let overflow = v =>
  o(
    "overflow",
    switch (v) {
    | `visible => "visible"
    | `hidden => "hidden"
    | `scroll => "scroll"
    },
  );
let position = v =>
  o(
    "position",
    switch (v) {
    | `absolute => "absolute"
    | `relative => "relative"
    },
  );
let padding2 = (v, h) =>
  l([
    ("paddingHorizontal", h |> getSpace |> Values.space),
    ("paddingVertical", v |> getSpace |> Values.space),
  ]);
let padding4 = (l_, t, r, b) =>
  l([
    ("paddingLeft", l_ |> getSpace |> Values.space),
    ("paddingTop", t |> getSpace |> Values.space),
    ("paddingBottom", b |> getSpace |> Values.space),
    ("paddingRight", r |> getSpace |> Values.space),
  ]);
let padding = v => op("padding", s => s |> getSpace |> Values.space, v);
let paddingTop = v => o("paddingTop", v |> getSpace |> Values.space);
let paddingBottom = v => o("paddingBottom", v |> getSpace |> Values.space);
let paddingLeft = v => o("paddingLeft", v |> getSpace |> Values.space);
let paddingRight = v => o("paddingRight", v |> getSpace |> Values.space);
let margin2 = (v, h) =>
  l([
    ("marginVertical", v |> getSpace |> Values.space),
    ("marginHorizontal", h |> getSpace |> Values.space),
  ]);
let margin4 = (l_, t, r, b) =>
  l([
    ("marginLeft", l_ |> getSpace |> Values.space),
    ("marginTop", t |> getSpace |> Values.space),
    ("marginBottom", b |> getSpace |> Values.space),
    ("marginRight", r |> getSpace |> Values.space),
  ]);
let margin = v => op("margin", s => s |> getSpace |> Values.space, v);
let marginTop = v => o("marginTop", v |> getSpace |> Values.space);
let marginBottom = v => o("marginBottom", v |> getSpace |> Values.space);
let marginLeft = v => o("marginLeft", v |> getSpace |> Values.space);
let marginRight = v => o("marginRight", v |> getSpace |> Values.space);
let backgroundColor = v => o("backgroundColor", getColor(v) |> Values.color);
let overlayColor = v => o("overlayColor", getColor(v) |> Values.color);
let tintColor = v => o("tintColor", getColor(v) |> Values.color);
let borderRadius = v =>
  o("borderRadius", v |> getBorderRadius |> Values.int_cast);
let color = (~highlight=?, ~tint as _=?, v) => {
  let res = o("color", v |> getTextColor(~highlight?) |> Values.color);
  Js.log2("res", res);
  res;
};

let make = styleList => {
  styleList
  |> List.fold_left(
       (obj, el) =>
         switch (el) {
         | Some(e) => e |> dict_to_obj |> Js.Obj.assign(obj)
         | None => obj
         },
       Js.Obj.empty(),
     )
  |> toReactNativeStyle;
};
// let value = rule => {
//   rule->Obj.magic->Log.pass("rule")
// }
external fromReactNativeStyle: ReactNative.Style.t => Js.t({.}) = "%identity";
let merge = (a: ReactNative.Style.t, b: ReactNative.Style.t) => {
  Js.Obj.(
    empty()
    |> assign(b |> fromReactNativeStyle)
    |> assign(a |> fromReactNativeStyle)
  )
  |> toReactNativeStyle;
};
