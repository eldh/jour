// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Css from "./Css.bs.js";
import * as Core from "./Core.bs.js";
import * as React from "react";
import * as ReactNative from "react-native";
import * as TouchableOpacity from "./TouchableOpacity.bs.js";

function getLinkStyle(param) {
  return {
          hd: Css.display("inline"),
          tl: {
            hd: Css.textDecoration("underline"),
            tl: {
              hd: Css.cursor("pointer"),
              tl: {
                hd: Css.borderStyle("none"),
                tl: {
                  hd: Css.color(Core.Styles.getTextColor(undefined, "body")),
                  tl: {
                    hd: Css.transition(200, undefined, undefined, "color"),
                    tl: {
                      hd: Css.focus({
                            hd: Css.outlineStyle("none"),
                            tl: /* [] */0
                          }),
                      tl: {
                        hd: Css.selector(":focus:not(:active)", {
                              hd: Css.textShadow(undefined, undefined, Css.px(3), Core.Styles.getColor(undefined, 0.4, "primary")),
                              tl: /* [] */0
                            }),
                        tl: {
                          hd: Css.active({
                                hd: Css.opacity(0.5),
                                tl: /* [] */0
                              }),
                          tl: /* [] */0
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        };
}

function Link(Props) {
  var $staropt$star = Props.onClick;
  var $staropt$star$1 = Props.size;
  var $staropt$star$2 = Props.lineHeight;
  var $staropt$star$3 = Props.weight;
  var children = Props.children;
  if ($staropt$star === undefined) {
    ((function (prim) {
          
        }));
  }
  $staropt$star$1 !== undefined;
  $staropt$star$2 !== undefined;
  $staropt$star$3 !== undefined;
  return React.createElement(ReactNative.Text, {
              children: children
            });
}

function Link$Button(Props) {
  var onClick = Props.onClick;
  var $staropt$star = Props.size;
  var $staropt$star$1 = Props.lineHeight;
  var $staropt$star$2 = Props.weight;
  var children = Props.children;
  $staropt$star !== undefined;
  $staropt$star$1 !== undefined;
  $staropt$star$2 !== undefined;
  return React.createElement(TouchableOpacity.make, {
              onPress: onClick,
              children: children
            });
}

var Button = {
  make: Link$Button
};

var make = Link;

export {
  getLinkStyle ,
  make ,
  Button ,
  
}
/* Core Not a pure module */
