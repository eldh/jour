// open ReactNative;

[@bs.module "./StackMap"]
external childMap:
  ((React.element, bool) => React.element, React.element) => React.element =
  "stackMap";

module Styles = {
  open S;
  let base = (~direction, ~align, ()) =>
    (
      switch (direction) {
      | `column => []
      | `row => [flexDirection(`row)]
      }
    )
    |> List.append([
         flexShrink(1.),
         justifyContent(`flexStart),
         alignItems(align),
         alignContent(`flexStart),
       ])
    |> S.make;
  let make = (~margin, ~direction, ()) =>
    (
      switch (direction) {
      | `column => [marginBottom(margin)]
      | `row => [flexDirection(`row), marginRight(margin)]
      }
    )
    |> List.append([flexShrink(0.), flexGrow(0.), flexBasis(`pct(100))])
    |> S.make;
};

[@react.component]
let make =
    (~margin as m=`double, ~direction=`column, ~align=`center, ~children) => {
  <ReactNative.View style={Styles.base(~direction, ~align, ())}>
    {children
     |> childMap((child, last) => {
          last
            ? child
            : <>
                child
                <ReactNative.View
                  style=S.([paddingLeft(m), alignSelf(`stretch)] |> S.make)>
                  React.null
                </ReactNative.View>
              </>
        })}
  </ReactNative.View>;
};