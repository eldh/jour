// Generated by BUCKLESCRIPT, PLEASE EDIT WITH CARE

import * as S from "./S.bs.js";
import * as View from "./View.bs.js";
import * as React from "react";

function Spacer(Props) {
  var size_Opt = Props.size;
  var size_ = size_Opt !== undefined ? size_Opt : /* single */958490248;
  var style = S.make({
        hd: S.marginBottom(size_),
        tl: /* [] */0
      });
  return React.createElement(View.make, {
              style: style,
              children: null
            });
}

var make = Spacer;

export {
  make ,
  
}
/* S Not a pure module */
