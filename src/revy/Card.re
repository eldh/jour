let useCardStyle = (~padding as p=?, ~margin as m=?, ()) => {
  S.(
    [
      backgroundColor(`bodyUp1),
      flexWrap(`wrap),
      flexDirection(`column),
      alignItems(`stretch),
      borderRadius(`large),
      borderWidth(1.),
      borderColor(`highlight((8, `body))),
      borderStyle(`solid),
      margin(m),
      padding(p),
      shadowOffset((0., 4.)),
      shadowColor(`unsafeCustomColor(`lab((0., 0., 0., 1.)))),
      shadowOpacity(Core.Styles.getIsLight() ? 0.05 : 0.35),
      shadowRadius(5.),
    ]
    |> make
  );
};

[@react.component]
let make =
    (~style as style_=?, ~grow=1., ~padding=`single, ~margin=?, ~children, ()) => {
  let default = useCardStyle(~padding, ~margin?, ());
  let style = style_->Belt.Option.mapWithDefault(default, S.merge(default));

  <ReactNative.View style> children </ReactNative.View>;
};