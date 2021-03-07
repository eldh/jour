@react.component
let make = (~date) => {
  let (value, _) = DiaryHooks.useDiaryText(date)

  <ReactNative.View
    style={
      open S
      list{flexGrow(1.)} |> S.make
    }>
    <Box align=#center padding=#half alignContent=#center grow=1. height=#pct(100.)>
      <Box maxWidth=#pct(100.) width=#px(621) grow=1. overflow=#visible>
        <Box direction=#row grow=0. alignSelf=#flexStart>
          <Text weight=#_700 size=4>
            {DateFns.format(
              date,
              "eeee dd LLLL" ++ (
                date->DateFns.isSameYear(Js.Date.fromFloat(Js.Date.now())) ? "" : " yyyy"
              ),
            )->String.capitalize_ascii}
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
              justifyContent(#flexStart),
              alignItems(#stretch),
              flexGrow(1.),
            } |> S.make
          }>
          <Text size=1 letterSpacing=0.5> {value} </Text>
        </ReactNative.ScrollView>
      </Box>
    </Box>
  </ReactNative.View>
}
