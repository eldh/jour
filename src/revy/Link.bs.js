// Generated by BUCKLESCRIPT, PLEASE EDIT WITH CARE

import * as Css from "./Css.bs.js";
import * as Core from "./Core.bs.js";
import * as React from "react";
import * as ReactNative from "react-native";
import * as TouchableOpacity from "./TouchableOpacity.bs.js";

function getLinkStyle(param) {
  return {
          hd: Css.display(/* inline */423610969),
          tl: {
            hd: Css.textDecoration(/* underline */131142924),
            tl: {
              hd: Css.cursor(/* pointer */-786317123),
              tl: {
                hd: Css.borderStyle(/* none */-922086728),
                tl: {
                  hd: Css.color(Core.Styles.getTextColor(undefined, /* body */-1055163742)),
                  tl: {
                    hd: Css.transition(200, undefined, undefined, "color"),
                    tl: {
                      hd: Css.focus({
                            hd: Css.outlineStyle(/* none */-922086728),
                            tl: /* [] */0
                          }),
                      tl: {
                        hd: Css.selector(":focus:not(:active)", {
                              hd: Css.textShadow(undefined, undefined, Css.px(3), Core.Styles.getColor(undefined, 0.4, /* primary */58474434)),
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
  Props.href;
  Props.onClick;
  Props.size;
  Props.lineHeight;
  Props.margin;
  Props.weight;
  Props.tintColor;
  var children = Props.children;
  return React.createElement(ReactNative.Text, {
              children: children
            });
}

function Link$Button(Props) {
  var onClick = Props.onClick;
  Props.size;
  Props.lineHeight;
  Props.margin;
  Props.weight;
  Props.tintColor;
  var children = Props.children;
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