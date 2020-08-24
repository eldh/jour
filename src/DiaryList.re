type t = {
  id: Credt.Util.id,
  date: Js.Date.t,
  content: option(string),
};

type update =
  | SetDate(Js.Date.t)
  | SetContent(option(string));

module Config = {
  type nonrec t = t;
  type nonrec update = update;
  let getId = u => u.id;
  let moduleId = "DiaryList" |> Credt.Util.idOfString;
  let reducer = entry =>
    fun
    | SetDate(date) => ({...entry, date}, SetDate(entry.date))
    | SetContent(content) => (
        {...entry, content},
        SetContent(entry.content),
      );
};

let makeEntry = (date, content) => {id: Credt.Util.makeId(), date, content};

include Credt.List.Make(Config);
module Context =
  CredtListContext.Make({
    type nonrec t = t;
    type nonrec update = update;
    let reducer = Config.reducer;
    let getId = o => o.id;
    let moduleId = "DiaryList"->Credt.Util.idOfString;
  });
