[@bs.send] external blur: Js.t({..}) => unit = "blur";

/**
 This is the first line. _Italicized_ word.

 * This is a bullet point.
 * This is the second point. */

/**
 This is the first line. _Italicized_ word.

 * This is a bullet point.
 * This is the second point. */
[@react.component]
let make =
    (
      ~a11yTitle as _a11yTitle=?,
      ~style as _=[],
      ~position=`relative,
      ~align=`flexStart,
      ~alignSelf=`auto,
      ~alignContent=`flexStart,
      ~backgroundColor=`transparent,
      ~grow=1.,
      ~wrap=`wrap,
      ~shrink=0.,
      ~justify=`flexStart,
      ~direction=`column,
      ~onlyFocusOnTab as _=true,
      ~padding=?,
      ~margin=?,
      ~basis=`auto,
      ~height=`auto,
      ~width=`auto,
      ~maxWidth=`auto,
      ~overflow=`scroll,
      ~borderRadius=`none,
      ~onPress=?,
      ~children,
      (),
    ) => {
  let style =
    Box.getBoxStyle(
      ~position,
      ~align,
      ~alignSelf,
      ~alignContent,
      ~backgroundColor,
      ~grow,
      ~wrap,
      ~shrink,
      ~justify,
      ~basis,
      ~direction,
      ~padding,
      ~margin,
      ~height,
      ~width,
      ~maxWidth,
      ~overflow,
      ~borderRadius,
      (),
    );
  <Core.BackgroundColorContext.Provider value=backgroundColor>

      <ReactNative.TouchableOpacity
        onPress=?{
          switch (onPress) {
          | Some(fn) => Some(e => fn(e))
          | None => None
          }
        }>
        <View style> children </View>
      </ReactNative.TouchableOpacity>
    </Core.BackgroundColorContext.Provider>;
    // style
};
