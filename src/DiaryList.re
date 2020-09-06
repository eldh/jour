type t = {
  id: Credt.Util.id,
  date: Js.Date.t,
  // content: option(string),
};

type update =
  | SetDate(Js.Date.t);

module Config = {
  type nonrec t = t;
  type nonrec update = update;
  let getId = u => u.id;
  let moduleId = "DiaryList" |> Credt.Util.idOfString;
  let reducer = entry =>
    fun
    | SetDate(date) => ({...entry, date}, SetDate(entry.date));
};

let makeEntry = (name, date) => {id: Credt.Util.idOfString(name), date};

include Credt.List.Make(Config);
let use = () => {
  let (_, forceUpdate) = React.useReducer((c, _) => c + 1, 0);
  let valRef = React.useRef(instance.getSnapshot());
  React.useEffect0(() => {
    let listener = _ops => {
      valRef.current = instance.getSnapshot();
      forceUpdate();
    };
    instance.addChangeListener(listener);
    Some(_ => removeChangeListener(listener));
  });
  valRef.current;
};
