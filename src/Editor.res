@react.component
let make = () => {
  let (date, _) = DiaryHooks.useDiaryDate()
  let (value, setValue) = DiaryHooks.useDiaryText(date)
  <React.Fragment>
    <Box align=#center padding=#half alignContent=#center grow=1. height=#pct(100.)>
      <Box maxWidth=#pct(100.) width=#px(613) grow=1.>
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
  </React.Fragment>
}
