let now = () => Js.Date.fromFloat(Js.Date.now())

type state = {
  date: Js.Date.t,
  outOfDate: bool,
}
type action =
  | SetCurrentDate(Js.Date.t)
  | SetOutOfDate
let reducer = (state, action) =>
  switch action {
  | SetOutOfDate => {...state, outOfDate: true}
  | SetCurrentDate(date) => {date: date, outOfDate: false}
  }
let initialState = {date: now(), outOfDate: false}

let useDiaryDate = () => {
  let ({date, outOfDate}, dispatch) = React.useReducer(reducer, initialState)
  Hooks.useInterval(
    2000,
    () =>
      if !DateFns.isSameDay(now(), date) {
        dispatch(SetOutOfDate)
      },
    [date],
  )
  (date, outOfDate ? Some(() => dispatch(SetCurrentDate(now()))) : None)
}

let useDiaryText = date => {
  let (value, setValue) = React.useState(() => "")
  let hasReadFileRef = React.useRef(false)

  React.useEffect1(() => {
    Js.log("read file")
    DiaryFs.readDiaryFromFs(~date, ())->Promise.get(result =>
      switch result {
      | Ok(content) => {
          hasReadFileRef.current = true
          setValue(_ => content)
        }
      | Error(e) => Js.log2("read  file error: ", e)
      }
    )
    None
  }, [])
  React.useEffect1(() => {
    if value !== "" && hasReadFileRef.current {
      DiaryFs.writeDiaryToFs(~date, ~contents=value, ())->Promise.get(x =>
        switch x {
        | Ok() => ()
        | Error(e) => Js.log2("write to file error: ", e)
        }
      )
    }
    None
  }, [value])
  (value, v => setValue(_ => v))
}

let useDiaryList = () =>
  Hooks.useInterval(
    5000,
    () =>
      DiaryFs.getDiaryEntries()->Promise.get(res =>
        switch res {
        | Ok(entries) =>
          open DiaryList
          entries
          ->Belt.List.keepMap(((name, date)) => {
            let entry = makeEntry(name, date)
            switch get(entry.id) {
            | Some(_e) => None
            | None => Some(Append(entry))
            }
          })
          ->apply
          ->(_ => Js.log2("Got diary list: ", entries))
          ->ignore
        | Error(e) => Js.log2("Error fetching diary list: ", e)
        }
      ),
    [],
  )

@react.component
let make = () => {
  let (date, handleChangeDate) = useDiaryDate()
  let (value, setValue) = useDiaryText(date)
  useDiaryList()
  // let v = DiaryList.use()
  // Js.log2("DiaryList", v->Belt.List.toArray)

  <ReactNative.View
    style={
      open S
      list{flexGrow(1.)} |> S.make
    }>
    <Box align=#center padding=#half alignContent=#center grow=1. height=#pct(100)>
      <Box maxWidth=#pct(100) width=#px(600) grow=1.>
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
          <Text weight=#_700 size=4 color=#quiet>
            {DateFns.format(date, "eeee dd LLLL")->String.capitalize_ascii}
          </Text>
        </Box>
        <Spacer />
        <ReactNative.ScrollView
          style={
            open S
            list{width(#pct(100)), flexGrow(1.), backgroundColor(#primary)} |> S.make
          }
          contentContainerStyle={
            open S
            list{
              width(#pct(100)),
              alignContent(#stretch),
              justifyContent(#center),
              alignItems(#stretch),
              flexGrow(1.),
              backgroundColor(#primary),
            } |> S.make
          }>
          <TextArea value onChangeText=setValue />
        </ReactNative.ScrollView>
      </Box>
    </Box>
  </ReactNative.View>
}
