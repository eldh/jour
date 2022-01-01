// Generated by ReScript, PLEASE EDIT WITH CARE

import * as S from "./S.bs.js";
import * as List from "rescript/lib/es6/list.js";
import * as React from "react";
import * as StackMap from "./StackMap";
import * as ReactNative from "react-native";

function childMap(prim0, prim1) {
  return StackMap.stackMap(prim0, prim1);
}

function base(direction, align, param) {
  return S.make(List.append({
                  hd: S.flexShrink(1),
                  tl: {
                    hd: S.justifyContent("flexStart"),
                    tl: {
                      hd: S.alignItems(align),
                      tl: {
                        hd: S.alignContent("flexStart"),
                        tl: /* [] */0
                      }
                    }
                  }
                }, direction === "row" ? ({
                      hd: S.flexDirection("row"),
                      tl: /* [] */0
                    }) : /* [] */0));
}

function make(margin, direction, param) {
  return S.make(List.append({
                  hd: S.flexShrink(0),
                  tl: {
                    hd: S.flexGrow(0),
                    tl: {
                      hd: S.flexBasis({
                            NAME: "pct",
                            VAL: 100
                          }),
                      tl: /* [] */0
                    }
                  }
                }, direction === "row" ? ({
                      hd: S.flexDirection("row"),
                      tl: {
                        hd: S.marginRight(margin),
                        tl: /* [] */0
                      }
                    }) : ({
                      hd: S.marginBottom(margin),
                      tl: /* [] */0
                    })));
}

var Styles = {
  base: base,
  make: make
};

function Stack(Props) {
  var mOpt = Props.margin;
  var directionOpt = Props.direction;
  var alignOpt = Props.align;
  var children = Props.children;
  var m = mOpt !== undefined ? mOpt : "double";
  var direction = directionOpt !== undefined ? directionOpt : "column";
  var align = alignOpt !== undefined ? alignOpt : "center";
  return React.createElement(ReactNative.View, {
              style: base(direction, align, undefined),
              children: StackMap.stackMap((function (child, last) {
                      if (last) {
                        return child;
                      } else {
                        return React.createElement(React.Fragment, undefined, child, React.createElement(ReactNative.View, {
                                        style: S.make({
                                              hd: S.paddingLeft(m),
                                              tl: {
                                                hd: S.alignSelf("stretch"),
                                                tl: /* [] */0
                                              }
                                            }),
                                        children: null
                                      }));
                      }
                    }), children)
            });
}

var make$1 = Stack;

export {
  childMap ,
  Styles ,
  make$1 as make,
  
}
/* S Not a pure module */
