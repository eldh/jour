open Core;
exception InvalidValue(string);

let getTextStyles =
    (
      ~extraStyle=[],
      ~size,
      ~color as color_,
      ~quiet=false,
      ~tintColor as tint=?,
      ~fontFamily as fontFamily_=`body,
      ~textDecoration as _textDecoration_=`none,
      ~lineHeight as lineHeight_,
      ~weight as weight_,
      (),
    ) => {
  S.[
    color(~highlight=?quiet ? Some(-30) : None, ~tint?, color_),
    // textDecoration(textDecoration_),
    // fontFamily(fontFamily_),
    lineHeight(
      Styles.getLineHeight(~fontSize=size, ~extraHeight=lineHeight_, ()),
    ),
    fontSize(size),
    fontWeight(weight_),
    ...extraStyle,
  ]
  |> S.make;
};

[@react.component]
let make =
    (
      ~weight=`normal,
      ~color=`body,
      ~size=0,
      ~lineHeight=0,
      ~textDecoration=?,
      ~quiet=false,
      ~tintColor=?,
      ~style=?,
      ~children: string,
      (),
    ) => {
  let styles =
    getTextStyles(
      ~extraStyle=?style,
      ~size,
      ~quiet,
      ~lineHeight,
      ~color,
      ~textDecoration?,
      ~weight,
      ~tintColor?,
      (),
    );
  UnsafeCreateReactElement.create(
    ReactNative.Text.make,
    {"style": styles, "children": children},
  );
};

module String = {
  [@react.component]
  let make =
      (
        ~weight=`normal,
        ~tag=ReactNative.Text.make,
        ~size=0,
        ~quiet=false,
        ~style=?,
        ~lineHeight=0,
        ~textDecoration=?,
        ~color=`body,
        ~tintColor=?,
        ~children,
        (),
      ) => {
    let styles =
      getTextStyles(
        ~extraStyle=?style,
        ~size,
        ~quiet,
        ~lineHeight,
        ~textDecoration?,
        ~weight,
        ~color,
        ~tintColor?,
        (),
      );
    UnsafeCreateReactElement.create(
      tag,
      {"style": styles, "children": children->React.string},
    );
  };
};
module Block = {
  // TODO fix
  [@react.component]
  let make =
      (
        ~weight=`normal,
        ~tag=ReactNative.Text.make,
        ~size=0,
        ~quiet=false,
        ~style=?,
        ~lineHeight=0,
        ~textDecoration=?,
        ~color=`body,
        ~tintColor=?,
        ~children,
        (),
      ) => {
    let styles =
      getTextStyles(
        ~extraStyle=?style,
        ~size,
        ~quiet,
        ~lineHeight,
        ~textDecoration?,
        ~weight,
        ~color,
        ~tintColor?,
        (),
      );
    UnsafeCreateReactElement.create(
      tag,
      {"style": styles, "children": children},
    );
  };
};
