module type Config = {
  type t;
  type operation;
  let instance: Credt.Map.instanceT(t, operation);
};
module Make = (Config: Config) => {
  let context = React.createContext(Config.instance.getSnapshot());

  module Provider_ = {
    let makeProps = (~value, ~children, ()) => {
      "value": value,
      "children": children,
    };

    let make = React.Context.provider(context);
  };

  module Provider = {
    /* Providing context */
    [@react.component]
    let make = (~children) => {
      let (value, setValue) = React.useState(Config.instance.getSnapshot);
      React.useEffect1(
        () => {
          let listener = _ => {
            setValue(_ => Config.instance.getSnapshot());
          };
          Config.instance.addChangeListener(listener);
          Some(() => Config.instance.removeChangeListener(listener));
        },
        [||],
      );
      <Provider_ value> children </Provider_>;
    };
  };

  let useById = id => {
    context->React.useContext->Belt.Map.String.get(id->Obj.magic);
  };
};
