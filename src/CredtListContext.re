module Make = (Config: Credt.List.ListConfig) => {
  module MyList = Credt.List.Make(Config);

  let context = React.createContext(MyList.instance);

  module Provider = {
    let makeProps = (~children, ()) => {
      "value": MyList.instance,
      "children": children,
    };

    let make = React.Context.provider(context);
  };
  // /* Using context */
  // [@react.component]
  // let make = () => {
  //   let (value, setValue) = React.useContext(context);
  //   let onClick = _ => setValue(prevValue => prevValue ++ "!");
  //   <button onClick> {React.string(value)} </button>;
  // };
};
