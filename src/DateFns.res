type locale
type localeConfig = {locale: locale}
@bs.module("date-fns/locale") external seLocale: locale = "sv"

@bs.module("date-fns")
external addMinutes: (Js.Date.t, int) => Js.Date.t = "addMinutes"

@bs.module("date-fns")
external subMinutes: (Js.Date.t, int) => Js.Date.t = "subMinutes"

@bs.module("date-fns")
external addHours: (Js.Date.t, int) => Js.Date.t = "addHours"

@bs.module("date-fns")
external subHours: (Js.Date.t, int) => Js.Date.t = "subHours"

@bs.module("date-fns")
external subDays: (Js.Date.t, int) => Js.Date.t = "subDays"

@bs.module("date-fns")
external addDays: (Js.Date.t, int) => Js.Date.t = "addDays"
@bs.module("date-fns")
external _format: (Js.Date.t, string, localeConfig) => string = "format"

let format = (date, string) => _format(date, string, {locale: seLocale})

@bs.module("date-fns")
external isAfter: (Js.Date.t, Js.Date.t) => bool = "isAfter"

@bs.module("date-fns")
external differenceInDays: (Js.Date.t, Js.Date.t) => float = "differenceInDays"

@bs.module("date-fns")
external differenceInCalendarDays: (Js.Date.t, Js.Date.t) => int = "differenceInCalendarDays"

@bs.module("date-fns")
external formatDistance: (Js.Date.t, Js.Date.t) => string = "formatDistance"

@bs.module("date-fns")
external startOfDay: Js.Date.t => Js.Date.t = "startOfDay"

@bs.module("date-fns") external getHours: Js.Date.t => int = "getHours"

@bs.module("date-fns") external getMinutes: Js.Date.t => int = "getMinutes"

@bs.module("date-fns")
external compareAsc: (Js.Date.t, Js.Date.t) => int = "compareAsc"

@bs.module("date-fns")
external compareDesc: (Js.Date.t, Js.Date.t) => int = "compareDesc"

@bs.module("date-fns")
external isSameDay: (Js.Date.t, Js.Date.t) => bool = "isSameDay"

@bs.module("date-fns")
external isSameMinute: (Js.Date.t, Js.Date.t) => bool = "isSameMinute"
