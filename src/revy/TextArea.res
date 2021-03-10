type el = {focus: unit => unit}

open S
let style = list{
  backgroundColor(#body),
  fontWeight(#normal),
  color(#body),
  padding2(#noSpace, #noSpace),
  width(#pct(100.)),
  height(#pct(100.)),
  flexGrow(1.),
  fontSize(1),
  flexBasis(#pct(100.)),
  // fontFamily(#body),
  letterSpacing(0.5),
  lineHeight(Core.Styles.getLineHeight(~fontSize=0, ~extraHeight=1, ())),
  // Some({"lineHeight": 20}->Obj.magic),
  // Some({"color": "#ffffff"}->Obj.magic),
} |> S.make
@react.component
let make = (~onChangeText, ~value) => {
  // let ref = React.useRef(Js.Nullable.null)
  // React.useEffect0(() => {
  //   Js.log2("el: ", ref.current)
  //   let el: option<el> = ref.current->Obj.magic->Js.Nullable.to_opt
  //   el->Belt.Option.forEach(el => el.focus())
  //   None
  // })
  <ReactNative.TextInput value onChangeText style multiline=true autoCorrect=true spellCheck=true />
}
