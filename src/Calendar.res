@@warning("-27")
let now = () => Js.Date.fromFloat(Js.Date.now())

let padMonthStart = date => {
  let startOfMonth = date->DateFns.startOfMonth
  let diff = DateFns.differenceInCalendarDays(startOfMonth, startOfMonth->DateFns.startOfWeek)
  Belt_Array.makeBy(diff, i => startOfMonth->DateFns.subDays(diff - i))
}
let padMonthEnd = date => {
  let endOfMonth = date->DateFns.endOfMonth->DateFns.startOfDay
  let diff = DateFns.differenceInCalendarDays(endOfMonth->DateFns.endOfWeek, endOfMonth)
  Belt_Array.makeBy(diff, i => endOfMonth->DateFns.addDays(i + 1)->DateFns.startOfDay)
}

module Date = {
  let style = {
    open S
    list{width(#px(28)), alignItems(#center)} |> make
  }
  @react.component
  let make = (~date, ~isToday, ~isSameMonth, ~isActive, ~onPress, ()) => {
    <ReactNative.TouchableOpacity
      disabled={!isSameMonth || !isActive} activeOpacity={0.7} focusedOpacity={0.9} onPress style>
      {isSameMonth
        ? <Text weight=#_700 color={isToday ? #primary : isActive ? #body : #faint}>
            {date->DateFns.format("d")}
          </Text>
        : React.null}
    </ReactNative.TouchableOpacity>
  }
}

module Month = {
  let style =
    list{
      S.width(#px(28 * 7)),
      S.height(#px(28 * 6)),
      S.flexDirection(#row),
      S.flexWrap(#wrap),
    } |> S.make
  @react.component
  let make = (~month, ~today, ~activeDates=[], ~onPressDate, ()) => {
    let monthLength = month->DateFns.getDaysInMonth
    let monthStart = month->DateFns.startOfMonth
    let daysInMonth = Belt.Array.makeBy(monthLength, i => monthStart->DateFns.setDate(i + 1))
    let daysBefore = month->padMonthStart
    let daysAfter = month->padMonthEnd
    let allDays = Tablecloth.Array.concatenate([daysBefore, daysInMonth, daysAfter])

    <Box>
      <Text weight=#bold> {month->DateFns.format("MMMM")->String.capitalize} </Text>
      <ReactNative.View style>
        {allDays
        ->Tablecloth.Array.map(~f=d => {
          <Date
            date=d
            key={d->DateFns.format("yyyy MM dd")}
            isToday={today->DateFns.isSameDay(d)}
            onPress={_ => onPressDate(d)}
            isSameMonth={month->DateFns.isSameMonth(d)}
            isActive={activeDates->Tablecloth.Array.any(~f=DateFns.isSameDay(d))}
          />
        })
        ->React.array}
      </ReactNative.View>
    </Box>
  }
}

module Year = {
  @react.component
  let make = (~year, ~today, ~activeDates, ~onPressDate, ()) => {
    <Box width=#px(621) padding=#half>
      <Text weight=#_700 size=4> {year->DateFns.format("yyyy")} </Text>
      <Box
        direction=#row
        wrap=#wrap
        style={list{S.width(#px(621))} |> S.make}
        marginBottom=#number(48)>
        {Belt_Array.makeBy(12, i => {
          let month = year->DateFns.addMonths(i)
          <Month key={i->string_of_int} onPressDate ?activeDates today month />
        })->React.array}
      </Box>
    </Box>
  }
}

@react.component
let make = (~onOpenDate, ~diaryList) => {
  let today = now()
  let firstDate =
    diaryList
    ->Tablecloth.Option.map(~f=d =>
      d
      ->Tablecloth.List.foldLeft(~initial=today, ~f=((_, date), memo) =>
        memo->DateFns.isAfter(date) ? date : memo
      )
      ->DateFns.startOfYear
    )
    ->Tablecloth.Option.withDefault(~default=today->DateFns.startOfYear)

  let allYears =
    (DateFns.differenceInYears(today, firstDate) + 1)
    ->Belt_Array.makeBy(i => firstDate->DateFns.addYears(i))
    ->Belt_Array.reverse
  let activeDates =
    diaryList->Tablecloth.Option.map(~f=d =>
      d->Tablecloth.List.map(~f=((_, date)) => date)->Tablecloth.Array.from_list
    )
  let onPressDate = date => {
    onOpenDate(date)
  }

  <ReactNative.View
    style={
      open S
      list{flexGrow(1.), alignItems(#center)} |> make
    }>
    <ReactNative.FlatList
      initialNumToRender={1}
      getItemLayout={(data, index) => {
        length: 1024.,
        offset: (1024 * index)->float_of_int,
        index: index,
      }}
      renderItem={({item}) =>
        <Year key={item->DateFns.format("yyyy")} year={item} onPressDate activeDates today />}
      data={allYears}
      keyExtractor={(year, _) => year->DateFns.format("yyyy")}
    />
  </ReactNative.View>
}
