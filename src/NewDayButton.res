@react.component
let make = () => {
  let (_, handleChangeDate) = DiaryHooks.useDiaryDate()
  handleChangeDate->Belt.Option.mapWithDefault(React.null, cb =>
    <ReactNative.View
      style={list{
        S.flex(1.),
        S.flexGrow(1.),
        S.position(#absolute),
        S.bottom(#double),
        S.right(#double),
      }->S.make}>
      <FadeView>
        <ReactNative.TouchableOpacity
          style={list{
            S.padding(Some(#double)),
            S.borderRadius(#large),
            S.backgroundColor(#unsafeCustomColor(#lab(100., 0., 0., 0.05))),
            S.borderColor(#unsafeCustomColor(#lab(100., 0., 0., 0.1))),
            S.borderWidth(2.),
          }->S.make}
          onPress={_ => {
            cb()
          }}>
          <Text weight=#bold> {"New day"} </Text> <Text> {"Press to start a new entry"} </Text>
        </ReactNative.TouchableOpacity>
      </FadeView>
    </ReactNative.View>
  )
}
