// Generated by ReScript, PLEASE EDIT WITH CARE

import * as S from "./revy/S.bs.js";
import * as $$Text from "./revy/Text.bs.js";
import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as FadeView from "./FadeView.bs.js";
import * as DiaryHooks from "./DiaryHooks.bs.js";
import * as Belt_Option from "rescript/lib/es6/belt_Option.js";
import * as ReactNative from "react-native";

function NewDayButton(Props) {
  var match = DiaryHooks.useDiaryDate(undefined);
  return Belt_Option.mapWithDefault(match[1], null, (function (cb) {
                return React.createElement(ReactNative.View, {
                            style: S.make({
                                  hd: S.flex(1),
                                  tl: {
                                    hd: S.flexGrow(1),
                                    tl: {
                                      hd: S.position("absolute"),
                                      tl: {
                                        hd: S.bottom("double"),
                                        tl: {
                                          hd: S.right("double"),
                                          tl: /* [] */0
                                        }
                                      }
                                    }
                                  }
                                }),
                            children: React.createElement(FadeView.make, {
                                  children: React.createElement(ReactNative.TouchableOpacity, {
                                        style: S.make({
                                              hd: S.padding("double"),
                                              tl: {
                                                hd: S.borderRadius("large"),
                                                tl: {
                                                  hd: S.backgroundColor({
                                                        NAME: "unsafeCustomColor",
                                                        VAL: {
                                                          NAME: "lab",
                                                          VAL: [
                                                            100,
                                                            0,
                                                            0,
                                                            0.05
                                                          ]
                                                        }
                                                      }),
                                                  tl: {
                                                    hd: S.borderColor({
                                                          NAME: "unsafeCustomColor",
                                                          VAL: {
                                                            NAME: "lab",
                                                            VAL: [
                                                              100,
                                                              0,
                                                              0,
                                                              0.1
                                                            ]
                                                          }
                                                        }),
                                                    tl: {
                                                      hd: S.borderWidth(2),
                                                      tl: /* [] */0
                                                    }
                                                  }
                                                }
                                              }
                                            }),
                                        onPress: (function (param) {
                                            return Curry._1(cb, undefined);
                                          }),
                                        children: null
                                      }, React.createElement($$Text.make, {
                                            weight: "bold",
                                            children: "New day"
                                          }), React.createElement($$Text.make, {
                                            children: "Press to start a new entry"
                                          }))
                                })
                          });
              }));
}

var make = NewDayButton;

export {
  make ,
  
}
/* S Not a pure module */
