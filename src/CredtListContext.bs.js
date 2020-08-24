// Generated by BUCKLESCRIPT, PLEASE EDIT WITH CARE

import * as React from "react";
import * as List$Credt from "credt/library/List.bs.js";

function Make(Config) {
  var MyList = List$Credt.Make(Config);
  var context = React.createContext(MyList.instance);
  var makeProps = function (children, param) {
    return {
            value: MyList.instance,
            children: children
          };
  };
  var make = context.Provider;
  var Provider = {
    makeProps: makeProps,
    make: make
  };
  return {
          MyList: MyList,
          context: context,
          Provider: Provider
        };
}

export {
  Make ,
  
}
/* react Not a pure module */