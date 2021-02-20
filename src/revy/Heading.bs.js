// Generated by ReScript, PLEASE EDIT WITH CARE

import * as $$Text from "./Text.bs.js";
import * as React from "react";
import * as Caml_option from "bs-platform/lib/es6/caml_option.mjs";

function Heading(Props) {
  var levelOpt = Props.level;
  var style = Props.style;
  var colorOpt = Props.color;
  var $staropt$star = Props.margin;
  var children = Props.children;
  var level = levelOpt !== undefined ? levelOpt : "h1";
  var color = colorOpt !== undefined ? colorOpt : "body";
  if ($staropt$star === undefined) {
    
  }
  var match = level === "h2" ? [
      4,
      "bold"
    ] : (
      level === "h3" ? [
          3,
          "bold"
        ] : (
          level === "h4" ? [
              2,
              "bold"
            ] : (
              level === "h5" ? [
                  1,
                  "bold"
                ] : [
                  5,
                  "bold"
                ]
            )
        )
    );
  var tmp = {
    weight: match[1],
    color: color,
    size: match[0],
    children: children
  };
  if (style !== undefined) {
    tmp.style = Caml_option.valFromOption(style);
  }
  return React.createElement($$Text.make, tmp);
}

var make = Heading;

export {
  make ,
  
}
/* Text Not a pure module */
