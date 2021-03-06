let useDiaryList = () => {
  let (state, setState) = React.useState(() => None)
  Hooks.useInterval(
    5000,
    () =>
      DiaryFs.getDiaryEntries()->Promise.get(res =>
        switch res {
        | Ok(entries) => setState(_ => Some(entries))
        | Error(e) => Js.log2("Error fetching diary list: ", e)
        }
      ),
    [],
  )
  state
}

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
let initialState = {date: DateFns.now(), outOfDate: false}

let useDiaryDate = () => {
  let ({date, outOfDate}, dispatch) = React.useReducer(reducer, initialState)
  Hooks.useInterval(
    2000,
    () =>
      if !DateFns.isSameDay(DateFns.now(), date) {
        dispatch(SetOutOfDate)
      },
    [date],
  )
  (date, outOfDate ? Some(() => dispatch(SetCurrentDate(DateFns.now()))) : None)
}

let useDiaryText = date => {
  let (value, setValue) = React.useState(() => "")
  let hasReadFileRef = React.useRef(false)

  React.useEffect1(() => {
    DiaryFs.readDiaryFromFs(~date, ())->Promise.get(result =>
      switch result {
      | Ok(content) => {
          hasReadFileRef.current = true
          setValue(_ => content)
        }
      | Error(e) => Js.log2("read file error: ", e)
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
