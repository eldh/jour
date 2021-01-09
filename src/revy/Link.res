open Core
let getLinkStyle = () => {
  open Css
  list{
    display(#inline),
    textDecoration(#underline),
    cursor(#pointer),
    borderStyle(#none),
    color(Styles.getTextColor(#body)),
    transition(~duration=200, "color"),
    // hover([color(Styles.getTextColor(~highlight=-40, `body)]),
    focus(list{outlineStyle(#none)}),
    selector(
      ":focus:not(:active)",
      list{textShadow(~blur=px(3), Styles.getColor(~alpha=0.4, #primary))},
    ),
    active(list{opacity(0.5)}),
  }
}
@react.component
let make = (
  ~href as _,
  ~onClick=ignore,
  ~size=0,
  ~lineHeight=0,
  ~margin as _=?,
  ~weight=#normal,
  ~tintColor as _=?,
  ~children,
  (),
) =>
  // let textStyle =
  //   Text.getTextStyles(~tintColor?, ~size, ~lineHeight, ~weight, ());
  // let linkStyle = getLinkStyle();
  <ReactNative.Text>
  // href
  // onClick
  // className={
  //   [textStyle, linkStyle, Styles.getMargin(margin)]
  //   |> List.concat
  //   |> Css.style
  // }
    {children->React.string}
  </ReactNative.Text>

module Button = {
  @react.component
  let make = (
    ~onClick,
    ~size=0,
    ~lineHeight=0,
    ~margin as _=?,
    ~weight=#normal,
    ~tintColor as _=?,
    ~children,
    (),
  ) =>
    // let textStyle =
    // Text.getTextStyles(~tintColor?, ~size, ~lineHeight, ~weight, ());
    // let linkStyle = getLinkStyle(());
    <TouchableOpacity
    // grow=0.
    // padding=`padding(`noSpace)
      onPress=onClick>
      {children->React.string}
    </TouchableOpacity>
}
