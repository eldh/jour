open ReactNative;
type variant =
  | Error
  | Warning
  | Success
  | Primary
  | Secondary;

type size =
  | Small
  | Medium
  | Large;

module Styles = {
  open S;
  let base = [borderRadius(`medium), borderStyle(`solid), borderWidth(3.)];
  let make = (~variant, ~size, ~outline) => {
    let (fontSize, paddingV, paddingH) =
      switch (size) {
      | Small => (1, `half, `single)
      | Medium => (2, `single, `double)
      | Large => (3, `double, `triple)
      };
    let (bgColor, borderColor, textColor) =
      switch (variant, outline) {
      | (Primary, false) => (`primary, `primary, `body)
      | (Secondary, false) => (`secondary, `secondary, `secondary)
      | (Error, false) => (`error, `error, `error)
      | (Success, false) => (`success, `success, `success)
      | (Warning, false) => (`warning, `warning, `warning)
      | (Primary, true) => (`transparent, `primary, `body)
      | (Secondary, true) => (`transparent, `secondary, `body)
      | (Error, true) => (`transparent, `error, `body)
      | (Success, true) => (`transparent, `success, `body)
      | (Warning, true) => (`transparent, `warning, `body)
      };
    let text =
      [fontWeight(`_700), S.fontSize(fontSize), color(textColor)] |> S.make;
    let btn =
      [
        backgroundColor(bgColor),
        S.borderColor(borderColor),
        padding2(paddingV, paddingH),
        ...base,
      ]
      |> S.make;
    (text, btn);
  };
};

[@react.component]
let make =
    (
      ~onPress,
      ~disabled=false,
      ~variant=Secondary,
      ~size=Medium,
      ~outline=false,
      ~children,
    ) => {
  let (textStyle, btnStyle) = Styles.make(~variant, ~outline, ~size);
  Js.log2("textStyle", textStyle);

  <TouchableOpacity onPress style=btnStyle activeOpacity=0.8 disabled>
    <ReactNative.Text style=textStyle>
      children->React.string
    </ReactNative.Text>
  </TouchableOpacity>;
};
module Round = {
  [@react.component]
  let make =
      (
        ~onPress,
        ~disabled=false,
        ~variant=Secondary,
        ~size=Medium,
        ~outline=false,
        ~children,
      ) => {
    let (textStyle, btnStyle) = Styles.make(~variant, ~outline, ~size);
    <TouchableOpacity onPress style=btnStyle activeOpacity=0.8 disabled>
      <ReactNative.Text style=textStyle> children </ReactNative.Text>
    </TouchableOpacity>;
  };
};
