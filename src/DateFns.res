type locale
type localeConfig = {locale: locale}
@module("date-fns/locale") external seLocale: locale = "sv"

@module("date-fns")
external addMinutes: (Js.Date.t, int) => Js.Date.t = "addMinutes"

@module("date-fns")
external addHours: (Js.Date.t, int) => Js.Date.t = "addHours"

@module("date-fns")
external addDays: (Js.Date.t, int) => Js.Date.t = "addDays"

@module("date-fns")
external addMonths: (Js.Date.t, int) => Js.Date.t = "addMonths"

@module("date-fns")
external addYears: (Js.Date.t, int) => Js.Date.t = "addYears"

@module("date-fns")
external subMinutes: (Js.Date.t, int) => Js.Date.t = "subMinutes"

@module("date-fns")
external subHours: (Js.Date.t, int) => Js.Date.t = "subHours"

@module("date-fns")
external subDays: (Js.Date.t, int) => Js.Date.t = "subDays"

@module("date-fns")
external toString: Js.Date.t => string = "formatISO"

@module("date-fns")
external _format: (Js.Date.t, string, localeConfig) => string = "format"

let format = (date, string) => _format(date, string, {locale: seLocale})

@module("date-fns")
external _startOfWeek: (Js.Date.t, localeConfig) => Js.Date.t = "startOfWeek"

@module("date-fns")
external _endOfWeek: (Js.Date.t, localeConfig) => Js.Date.t = "endOfWeek"

@module("date-fns")
external isAfter: (Js.Date.t, Js.Date.t) => bool = "isAfter"

@module("date-fns")
external differenceInDays: (Js.Date.t, Js.Date.t) => int = "differenceInDays"

@module("date-fns")
external differenceInMonths: (Js.Date.t, Js.Date.t) => int = "differenceInMonths"

@module("date-fns")
external differenceInYears: (Js.Date.t, Js.Date.t) => int = "differenceInYears"

@module("date-fns")
external isEqual: (Js.Date.t, Js.Date.t) => bool = "isEqual"

@module("date-fns")
external differenceInCalendarDays: (Js.Date.t, Js.Date.t) => int = "differenceInCalendarDays"

@module("date-fns")
external formatDistance: (Js.Date.t, Js.Date.t) => string = "formatDistance"

@module("date-fns")
external startOfDay: Js.Date.t => Js.Date.t = "startOfDay"

@module("date-fns") external getMonth: Js.Date.t => int = "getMonth"
@module("date-fns") external getDaysInMonth: Js.Date.t => int = "getDaysInMonth"
@module("date-fns") external _startOfMonth: Js.Date.t => Js.Date.t = "startOfMonth"
@module("date-fns") external _startOfYear: Js.Date.t => Js.Date.t = "startOfYear"
@module("date-fns") external _endOfMonth: Js.Date.t => Js.Date.t = "endOfMonth"
@module("date-fns") external getDate: Js.Date.t => int = "getDate"

@module("date-fns") external setDate: (Js.Date.t, int) => Js.Date.t = "setDate"

@module("date-fns") external getDay: Js.Date.t => int = "getDay"

@module("date-fns") external getHours: Js.Date.t => int = "getHours"

@module("date-fns") external getMinutes: Js.Date.t => int = "getMinutes"

@module("date-fns")
external compareAsc: (Js.Date.t, Js.Date.t) => int = "compareAsc"

@module("date-fns")
external compareDesc: (Js.Date.t, Js.Date.t) => int = "compareDesc"

@module("date-fns")
external isSameDay: (Js.Date.t, Js.Date.t) => bool = "isSameDay"

@module("date-fns")
external isSameMinute: (Js.Date.t, Js.Date.t) => bool = "isSameMinute"

@module("date-fns")
external isSameMonth: (Js.Date.t, Js.Date.t) => bool = "isSameMonth"

@module("date-fns")
external isSameYear: (Js.Date.t, Js.Date.t) => bool = "isSameYear"

@module("date-fns-tz")
external _zonedTimeToUtc: (Js.Date.t, localeConfig) => Js.Date.t = "zonedTimeToUtc"

@module("date-fns-tz")
external _utcToZonedTime: (Js.Date.t, localeConfig) => Js.Date.t = "utcToZonedTime"

let utcToZonedTime = d => _utcToZonedTime(d, {locale: seLocale})
// let zonedTimeToUtc = d => _zonedTimeToUtc(d, {locale: seLocale})

let startOfMonth = d => d->_startOfMonth
let startOfYear = d => {
  d->_startOfYear
}
let endOfMonth = d => d->_endOfMonth
let startOfWeek = date => _startOfWeek(date, {locale: seLocale})
let endOfWeek = date => _endOfWeek(date, {locale: seLocale})

let now = () => Js.Date.fromFloat(Js.Date.now())
