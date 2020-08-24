// let defaultStyles = Css.[display(`flex), boxSizing(`borderBox)];

[@react.component]
let make =
    (
      ~style=?,
      ~children,
      (),
    ) => {
  <ReactNative.View ?style> children </ReactNative.View>;
};