module Make = (Config: Credt.List.ListConfig) => {
  module InternalList = Credt.List.Make(Config);
  let use = () => {
    let (_, forceUpdate) = React.useReducer((c, _) => c + 1, 0);
    let valRef = React.useRef(InternalList.instance.getSnapshot());
    React.useEffect0(() => {
      let listener = _ => {
        valRef.current = InternalList.instance.getSnapshot();
        forceUpdate();
      };
      InternalList.instance.addChangeListener(listener);
      Some(_ => InternalList.removeChangeListener(listener));
    });
    valRef.current;
  };
};
