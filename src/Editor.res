@react.component
let make = () => {
  let (date, handleChangeDate) = DiaryHooks.useDiaryDate()
  let (value, setValue) = DiaryHooks.useDiaryText(date)

  <ReactNative.View
    style={
      open S
      list{flexGrow(1.)} |> S.make
    }>
    <Box align=#center padding=#half alignContent=#center grow=1. height=#pct(100.)>
      <Box maxWidth=#pct(100.) width=#px(621) grow=1.>
        {handleChangeDate->Belt.Option.mapWithDefault(React.null, cb =>
          <Box grow=0.>
            <Button
              onPress={_ => {
                setValue("")
                cb()
              }}>
              "New date"
            </Button>
          </Box>
        )}
        <Box grow=0. alignSelf=#flexStart>
          <Text weight=#_700 size=4>
            {DateFns.format(date, "eeee dd LLLL")->String.capitalize_ascii}
          </Text>
        </Box>
        <Spacer />
        <ReactNative.ScrollView
          style={
            open S
            list{width(#pct(100.)), flexGrow(1.)} |> S.make
          }
          contentContainerStyle={
            open S
            list{
              width(#pct(100.)),
              alignContent(#stretch),
              justifyContent(#center),
              alignItems(#stretch),
              flexGrow(1.),
            } |> S.make
          }>
          <TextArea value onChangeText=setValue />
        </ReactNative.ScrollView>
      </Box>
    </Box>
  </ReactNative.View>
}
