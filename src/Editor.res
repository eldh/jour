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
  React.useEffect1(() => {
    DiaryFs.writeDiaryToFs(~date, ~contents=value, ())->Promise.get(x =>
      switch x {
      | Ok() => ()
      | Error(e) => Js.log2("write to file error: ", e)
      }
    )
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
          ->ignore
        // ->(_ => Js.log2("Got diary list: ", entries))
        // ->ignore
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
  let v = DiaryList.use()
  Js.log2("DiaryList", v->Belt.List.toArray)

  <Box align=#center padding=#half alignContent=#center grow=1. height=#pct(100)>
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
      <Text fontFamily=#mono color=#quiet>
        {DateFns.format(date, "eeee dd LLLL")->String.capitalize_ascii}
      </Text>
    </Box>
    <Spacer />
    <Box maxWidth=#pct(100) width=#px(700) backgroundColor=#secondary grow=1.>
      <TextArea value onChangeText=setValue />
    </Box>
  </Box>
}