let getBoxStyle =
    (
      ~position as position_,
      ~align as align_,
      ~alignSelf as alignSelf_,
      ~alignContent as alignContent_,
      ~backgroundColor as backgroundColor_,
      ~grow as grow_,
      ~basis as basis_,
      ~wrap as wrap_,
      ~shrink as shrink_,
      ~justify as justify_,
      ~direction as direction_,
      ~padding as padding_,
      ~margin as margin_,
      ~height as height_,
      ~width as width_,
      ~maxWidth as maxWidth_,
      ~overflow as overflow_,
      ~borderRadius as borderRadius_,
      (),
    ) => {
  S.(
    [
      width(width_),
      maxWidth(maxWidth_),
      padding(padding_),
      margin(margin_),
      position(position_),
      alignSelf(alignSelf_),
      alignItems(align_),
      backgroundColor(backgroundColor_),
      alignContent(alignContent_),
      height(height_),
      overflow(overflow_),
      borderRadius(borderRadius_),
      flexShrink(shrink_),
      flexBasis(basis_),
      flexDirection(direction_),
      flexGrow(grow_),
      flexWrap(wrap_),
      justifyContent(justify_),
    ]
    |> make
  );
};

[@react.component]
let make =
    (
      ~style as _style_=?,
      ~position=`relative,
      ~align=`flexStart,
      ~alignSelf=`auto,
      ~alignContent=`flexStart,
      ~backgroundColor=`transparent,
      ~grow=1.,
      ~wrap=`wrap,
      ~shrink=0.,
      ~basis=`auto,
      ~justify=`flexStart,
      ~direction=`column,
      ~padding=?,
      ~margin=?,
      ~height=`auto,
      ~width=`auto,
      ~maxWidth=`auto,
      ~overflow=`scroll,
      ~borderRadius=`none,
      ~children,
      (),
    ) => {
  let style =
    getBoxStyle(
      ~position,
      ~align,
      ~alignSelf,
      ~alignContent,
      ~backgroundColor,
      ~grow,
      ~basis,
      ~wrap,
      ~shrink,
      ~justify,
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
    <View style> children </View>
  </Core.BackgroundColorContext.Provider>;
};
