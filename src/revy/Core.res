// type cssFontFamily = array(string);
exception InvalidValue(string)
let identity = a => a

type cssFontSize = [
  | #calc([#add | #sub], Css.length, Css.length)
  | #ch(float)
  | #cm(float)
  | #em(float)
  | #ex(float)
  | #inherit_
  | #initial
  | #mm(float)
  | #percent(float)
  | #pt(int)
  | #px(int)
  | #pxFloat(float)
  | #rem(float)
  | #unset
  | #vh(float)
  | #vmax(float)
  | #vmin(float)
  | #vw(float)
  | #zero
]

type cssLineHeight = [
  | #abs(float)
  | #calc([#add | #sub], Css.length, Css.length)
  | #ch(float)
  | #cm(float)
  | #em(float)
  | #ex(float)
  | #inherit_
  | #initial
  | #mm(float)
  | #normal
  | #percent(float)
  | #pt(int)
  | #px(int)
  | #pxFloat(float)
  | #rem(float)
  | #unset
  | #vh(float)
  | #vmax(float)
  | #vmin(float)
  | #vw(float)
  | #zero
]

type cssWidth = [
  | #auto
  | #calc([#add | #sub], Css.length, Css.length)
  | #ch(float)
  | #cm(float)
  | #em(float)
  | #ex(float)
  | #mm(float)
  | #percent(float)
  | #pt(int)
  | #px(int)
  | #pxFloat(float)
  | #rem(float)
  | #vh(float)
  | #vmax(float)
  | #vmin(float)
  | #vw(float)
  | #zero
]
type cssFontWeight = [
  | #black
  | #bold
  | #bolder
  | #extraBold
  | #extraLight
  | #inherit_
  | #initial
  | #light
  | #lighter
  | #medium
  | #normal
  | #num(int)
  | #semiBold
  | #thin
  | #unset
]

module Layout = {
  type rec t = [
    | #percent(float)
    | #eighth
    | #sixth
    | #quarter
    | #third
    | #half
    | #full
    | #unsafeCustomValue(cssWidth)
    | #auto
    | #responsive(t, t, t)
  ]
}

module Space = {
  type rec t = [
    | #auto
    | #noSpace
    | #half
    | #single
    | #double
    | #triple
    | #quad
    | #quint
    | #number(int)
    | #unsafeCustomValue(Css.length)
    | #responsive(t, t, t)
  ]
}

module Type = {
  type font = [#body | #title | #mono | #alt]
  type fontWeight = [#extraLight | #light | #normal | #bold | #extraBold]
}

module Color = {
  type rec backgroundColor = [
    | #primary
    | #secondary
    | #success
    | #warning
    | #error
    | #neutral
    | #brand1
    | #brand2
    | #body
    | #bodyDown1
    | #bodyDown2
    | #bodyDown3
    | #bodyUp1
    | #bodyUp2
    | #bodyUp3
    | #transparent
    | #highlight(int, backgroundColor)
    | #alpha(float, backgroundColor)
    | #unsafeCustomColor(Lab.t)
  ]

  type rec textColor = [
    | #primary
    | #secondary
    | #warning
    | #error
    | #success
    | #brand1
    | #brand2
    | #body
    | #quiet
    | #highlight(int, textColor)
    | #match_(backgroundColor)
    | #unsafeCustomColor(Lab.t)
  ]
}

type rec margin = [
  | #auto
  | #margin(Space.t)
  | #marginTop(Space.t)
  | #marginBottom(Space.t)
  | #marginLeft(Space.t)
  | #marginRight(Space.t)
  | #margin2(Space.t, Space.t)
  | #margin4(Space.t, Space.t, Space.t, Space.t)
  | #responsive(margin, margin, margin)
]

type rec padding = [
  | #padding(Space.t)
  | #paddingTop(Space.t)
  | #paddingBottom(Space.t)
  | #paddingLeft(Space.t)
  | #paddingRight(Space.t)
  | #padding2(Space.t, Space.t)
  | #padding4(Space.t, Space.t, Space.t, Space.t)
  | #responsive(padding, padding, padding)
]

@ocaml.doc("
  Base type for themes
 ")
type fonts = {
  body: list<string>,
  title: list<string>,
  mono: list<string>,
  alt: list<string>,
}

type borderRadii = {
  small: int,
  medium: int,
  large: int,
}

type colors = {
  neutral: Lab.t,
  primary: Lab.t,
  secondary: Lab.t,
  success: Lab.t,
  warning: Lab.t,
  error: Lab.t,
  brand1: Lab.t,
  brand2: Lab.t,
  body: Lab.t,
  bodyDown1: Lab.t,
  bodyDown2: Lab.t,
  bodyDown3: Lab.t,
  bodyUp1: Lab.t,
  bodyUp2: Lab.t,
  bodyUp3: Lab.t,
  bodyText: Lab.t,
  quiet: Lab.t,
}

type t = {
  colors: colors,
  fonts: fonts,
  fontScale: float,
  baseFontSize: int,
  baseGridUnit: int,
  width: int,
  borderRadii: borderRadii,
}

let responsive = (_theme, (s, m, l)) => {
  open Css
  list{media("(min-width: 30em)", m), media("(min-width: 50em)", l), ...s}
}
module BackgroundColorContext = {
  let defaultColor: Color.backgroundColor = #body
  let context = React.createContext(defaultColor)
  let provider = React.Context.provider(context)

  module Provider = {
    @react.component
    let make = (~value: Color.backgroundColor, ~children) => {
      let updateVal = value =>
        UnsafeCreateReactElement.create(Obj.magic(provider), {"value": value, "children": children})
      switch value {
      | #transparent => children
      | #alpha(a, _) => a > 0.49 ? updateVal(value) : children
      | _ => updateVal(value)
      }
    }
  }
}
module Private = {
  let alphaFn = (alpha, lab) =>
    switch lab {
    | #lab(l, a, b, _) => #lab(l, a, b, alpha)
    }

  let isLight = body => Lab.luminance(body) > 50.

  let rec backgroundColor = (~theme, ~alpha=?, ~highlight=?, v: Color.backgroundColor) => {
    let highlightFn = switch highlight {
    | Some(h) => Lab.highlight(~baseColor=theme.colors.body, h)
    | None => identity
    }
    switch v {
    | #primary => theme.colors.primary
    | #neutral => theme.colors.neutral
    | #secondary => theme.colors.secondary
    | #success => theme.colors.success
    | #warning => theme.colors.warning
    | #error => theme.colors.error
    | #brand1 => theme.colors.brand1
    | #brand2 => theme.colors.brand2
    | #body => theme.colors.body
    | #bodyDown1 => theme.colors.bodyDown1
    | #bodyDown2 => theme.colors.bodyDown2
    | #bodyDown3 => theme.colors.bodyDown3
    | #bodyUp1 => theme.colors.bodyUp1
    | #bodyUp2 => theme.colors.bodyUp2
    | #bodyUp3 => theme.colors.bodyUp3
    | #highlight(i, c) => backgroundColor(~theme, ~highlight=i, c)
    | #alpha(f, c) => backgroundColor(~theme, ~alpha=f, c)
    | #transparent => #lab(100., 100., 100., 0.)
    | #unsafeCustomColor(c) => c
    }
    |> highlightFn
    |> switch alpha {
    | Some(a) => alphaFn(a)
    | None => identity
    }
  }
  let textColor = (~theme, ~alpha=?, ~highlight=?, v: Color.textColor) => {
    let highlightFn = switch highlight {
    | Some(h) => Lab.highlight(~baseColor=theme.colors.body, h)
    | None => identity
    }
    switch v {
    | #primary => theme.colors.primary
    | #quiet => theme.colors.quiet
    | #unsafeCustomColor(c) => c
    | #secondary
    | #warning
    | #error
    | #success
    | #brand1
    | #brand2
    | #body
    | _ =>
      theme.colors.bodyText
    }
    |> highlightFn
    |> switch alpha {
    | Some(a) => alphaFn(a)
    | None => identity
    }
  }

  // let textColor = (~theme, ~highlight=?, ~tint=?, v: Color.textColor) => {
  //   let bgColor = backgroundColor(~theme, v);
  //   let highlightFn =
  //     switch (highlight) {
  //     | Some(h) => (bgColor |> isLight ? Lab.darken : Lab.lighten)(h)
  //     | None => identity
  //     };
  //   let (lightColor, darkColor) =
  //     isLight(theme.colors.body)
  //       ? (theme.colors.body, theme.colors.bodyText)
  //       : (theme.colors.bodyText, theme.colors.body);
  //   let tintC =
  //     switch (tint) {
  //     | None => None
  //     | Some(t) => Some(backgroundColor(~theme, t))
  //     };
  //   bgColor
  //   |> Lab.getContrastColor(~tint=?tintC, ~lightColor, ~darkColor)
  //   |> highlightFn;
  // };

  let fontFamily = (~theme, v) =>
    switch v {
    | #title => theme.fonts.title
    | #mono => theme.fonts.mono
    | #body => theme.fonts.body
    | #alt => theme.fonts.alt
    } |> String.concat(", ")

  let fontSize = (~theme, n) =>
    (theme.fontScale ** float_of_int(n) *. float_of_int(theme.baseFontSize))->int_of_float

  let fontWeight = (~theme as _, v) =>
    switch v {
    | #extraLight => #extraLight
    | #light => #light
    | #normal => #normal
    | #medium => #medium
    | #bold => #bold
    | #extraBold => #extraBold
    }

  let rec findMinStep = (test, i) => test(i) ? i : findMinStep(test, i + 1)

  let space = (~negative=false, ~theme, ~adjustPx=0, v): ReactNative.Style.size => {
    let length = v => theme.baseGridUnit * v - adjustPx |> float_of_int |> ReactNative.Style.dp
    let multiplier = negative ? -1 : 1
    switch v {
    | #auto => ReactNative.Style.auto
    | #noSpace => 0. |> ReactNative.Style.dp
    | #half => 1 * multiplier |> length
    | #single => 2 * multiplier |> length
    | #double => 4 * multiplier |> length
    | #triple => 6 * multiplier |> length
    | #quad => 8 * multiplier |> length
    | #quint => 10 * multiplier |> length
    | #number(i: int) => i * multiplier |> length
    | #unsafeCustomValue(v) => v
    | #closest(pixels) =>
      let rem = mod(pixels, theme.baseGridUnit)
      let extra = rem == 0 ? 0 : 1
      (pixels / theme.baseGridUnit + extra) * theme.baseGridUnit * multiplier
      |> float_of_int
      |> ReactNative.Style.dp
    | #responsive(_, _, _) => 6 * multiplier |> length // TODO Fix
    }
  }

  let getPx = v =>
    switch v {
    | #px(i) => i
    | _ => raise(InvalidValue("Not a pixel value"))
    }

  let lineHeight = (~theme, ~fontSize as size=0, ~extraHeight=0, ()) => {
    let va = findMinStep(
      i =>
        i * theme.baseGridUnit |> float_of_int > (size |> fontSize(~theme) |> float_of_int) *. 1.25,
      0,
    )
    (va + extraHeight) * theme.baseGridUnit |> float_of_int
  }
}
let createTheme = (
  ~fontScale=1.25,
  ~baseFontSize=16,
  ~baseLightness=70.,
  ~baseGridUnit=4,
  ~borderRadii={small: 5, medium: 8, large: 12},
  ~fonts={
    body: list{"-apple-system", "BlinkMacSystemFont", "sans-serif"},
    title: list{"-apple-system", "BlinkMacSystemFont", "sans-serif"},
    mono: list{"Courier"},
    alt: list{"-apple-system", "BlinkMacSystemFont", "sans-serif"},
  },
  ~hues={
    primary: #rgb(18, 120, 240) |> Lab.fromRGB,
    secondary: #rgb(100, 100, 100) |> Lab.fromRGB,
    warning: #rgb(214, 135, 5) |> Lab.fromRGB,
    success: #rgb(44, 173, 2) |> Lab.fromRGB,
    error: #rgb(230, 26, 26) |> Lab.fromRGB,
    brand1: #rgb(213, 54, 222) |> Lab.fromRGB,
    brand2: #rgb(54, 213, 222) |> Lab.fromRGB,
    body: #lab(10., 0., 0., 1.),
    bodyUp1: #lab(100., 0., 0., 1.),
    bodyUp2: #lab(100., 0., 0., 1.),
    bodyUp3: #lab(100., 0., 0., 1.),
    bodyDown1: #lab(98., 0., 0., 1.),
    bodyDown2: #lab(96., 0., 0., 1.),
    bodyDown3: #lab(94., 0., 0., 1.),
    bodyText: #lab(10., 0., 0., 1.),
    neutral: #rgb(40, 40, 40) |> Lab.fromRGB,
    quiet: #rgb(130, 130, 130) |> Lab.fromRGB,
  },
  ~gridWidth as width=960,
  (),
) => {
  let colors = {
    open Lab
    {
      primary: hues.primary |> lightness(baseLightness),
      secondary: hues.secondary |> lightness(baseLightness),
      warning: hues.warning |> lightness(baseLightness),
      success: hues.success |> lightness(baseLightness),
      error: hues.error |> lightness(baseLightness),
      brand1: hues.brand1 |> lightness(baseLightness),
      brand2: hues.brand2 |> lightness(baseLightness),
      body: hues.body,
      bodyDown1: hues.bodyDown1,
      bodyDown2: hues.bodyDown2,
      bodyDown3: hues.bodyDown3,
      bodyUp1: hues.bodyUp1,
      bodyUp2: hues.bodyUp2,
      bodyUp3: hues.bodyUp3,
      bodyText: hues.bodyText,
      quiet: hues.quiet,
      neutral: hues.neutral |> lightness(80.),
    }
  }
  {
    colors: colors,
    fonts: fonts,
    fontScale: fontScale,
    baseFontSize: baseFontSize,
    baseGridUnit: baseGridUnit,
    width: width,
    borderRadii: borderRadii,
  }
}

module DefaultTheme = {
  let theme = createTheme()
}

let currentTheme = ref(DefaultTheme.theme)
let setTheme = theme => currentTheme := theme
let getTheme = () => currentTheme.contents

// module Context = {
//   let context = React.createContext(DefaultTheme.theme);
//   let provider = React.Context.provider(context);

//   module Provider = {
//     [@react.component]
//     let make = (~value, ~children) => {
//       UnsafeCreateReactElement.create(
//         Obj.magic(provider),
//         {"value": value, "children": children},
//       );
//     };
//   };
// };
module Styles = {
  let getColor = (~highlight=?, ~alpha=?, c: Color.backgroundColor) =>
    Private.backgroundColor(~theme=getTheme(), ~highlight?, ~alpha?, c) |> Lab.toCss
  let getLabColor = (~highlight=?, ~alpha=?, c: Color.backgroundColor) =>
    Private.backgroundColor(~theme=getTheme(), ~highlight?, ~alpha?, c)
  let getTextColor = (~highlight=0, c: Color.textColor) =>
    Private.textColor(~theme=getTheme(), ~highlight, c) |> Lab.toCss

  let getBorderRadius = s => {
    let theme = getTheme()
    switch s {
    | #small => theme.borderRadii.small
    | #medium => theme.borderRadii.medium
    | #large => theme.borderRadii.large
    | #none => 0
    | #full => 200
    }
  }

  let getSpace = (~negative=?, ~adjustPx=0, s) =>
    Private.space(~negative?, ~theme=getTheme(), ~adjustPx, s)

  let getFontFamily = f => Private.fontFamily(~theme=getTheme(), f)

  let getFontSize = f => Private.fontSize(~theme=getTheme(), f)

  let getFontWeight = f => Private.fontWeight(~theme=getTheme(), f)

  let getLineHeight = (~fontSize=0, ~extraHeight=0, ()) =>
    Private.lineHeight(~theme=getTheme(), ~fontSize, ~extraHeight, ())

  let getIsLight = () => Private.isLight(getTheme().colors.body)

  type listenerId
  type mediaQueryList = {
    "matches": bool,
    "addListener": @bs.meth ((unit => unit) => listenerId),
    "removeListener": @bs.meth (listenerId => unit),
  }
  @bs.val @bs.scope("window")
  external matchMedia: string => mediaQueryList = "matchMedia"

  let useMatchesMedia = query => {
    let mql = matchMedia(query)
    let (value, setValue) = React.useState(() => mql["matches"])

    React.useLayoutEffect1(() => {
      let handler = mql["addListener"](() => setValue(_ => mql["matches"]))
      Some(() => mql["removeListener"](handler))
    }, [])

    value
  }
}
