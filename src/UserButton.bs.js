// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as UserMap from "./UserMap.bs.js";
import * as Belt_Option from "rescript/lib/es6/belt_Option.js";
import * as ReactNative from "react-native";

function UserButton(Props) {
  var user = Curry._1(UserMap.Context.useById, UserMap.baseUser.id);
  return React.createElement(ReactNative.TouchableOpacity, {
              onPress: (function (param) {
                  Curry._1(UserMap.apply, {
                        hd: {
                          TAG: /* Update */2,
                          _0: UserMap.baseUser.id,
                          _1: /* IncreaseAge */0
                        },
                        tl: /* [] */0
                      });
                  
                }),
              children: Belt_Option.mapWithDefault(user, null, (function (user) {
                      return React.createElement(ReactNative.View, {
                                  children: null
                                }, React.createElement(ReactNative.Text, {
                                      children: user.email,
                                      style: {
                                        color: "white"
                                      }
                                    }), React.createElement(ReactNative.Text, {
                                      children: user.name,
                                      style: {
                                        color: "white"
                                      }
                                    }), React.createElement(ReactNative.Text, {
                                      children: String(user.age),
                                      style: {
                                        color: "white"
                                      }
                                    }));
                    }))
            });
}

var make = UserButton;

export {
  make ,
  
}
/* react Not a pure module */
