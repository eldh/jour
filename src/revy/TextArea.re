[@react.component]
let make = (~onChangeText, ~value) => {
  open S;
  let style =
    [
      backgroundColor(`body),
      fontWeight(`normal),
      color(`body),
      padding2(`half, `half),
      width(`pct(100)),
      flexGrow(1.),
      fontFamily(`mono),
      lineHeight(Core.Styles.getLineHeight(~fontSize=0, ~extraHeight=1, ())),
      // Some({"lineHeight": 20}->Obj.magic),
      // Some({"color": "#ffffff"}->Obj.magic),
    ]
    |> S.make;
  <ReactNative.TextInput
    value
    onChangeText
    style
    multiline=true
    spellCheck=true
  />;
};
