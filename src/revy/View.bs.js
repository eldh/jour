// Generated by BUCKLESCRIPT, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Caml_option from "bs-platform/lib/es6/caml_option.js";
import * as ReactNative from "react-native";

function View(Props) {
  var style = Props.style;
  var children = Props.children;
  var tmp = {
    children: children
  };
  if (style !== undefined) {
    tmp.style = Caml_option.valFromOption(style);
  }
  return React.createElement(ReactNative.View, tmp);
}

var make = View;

export {
  make ,
  
}
/* react Not a pure module */