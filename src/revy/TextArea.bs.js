// Generated by ReScript, PLEASE EDIT WITH CARE

import * as S from "./S.bs.js";
import * as Core from "./Core.bs.js";
import * as React from "react";
import * as ReactNative from "react-native";

var style = S.make({
      hd: S.backgroundColor("transparent"),
      tl: {
        hd: S.fontWeight("normal"),
        tl: {
          hd: S.color(undefined, undefined, "body"),
          tl: {
            hd: S.padding2("noSpace", "noSpace"),
            tl: {
              hd: S.width({
                    NAME: "pct",
                    VAL: 100
                  }),
              tl: {
                hd: S.height({
                      NAME: "pct",
                      VAL: 100
                    }),
                tl: {
                  hd: S.flexGrow(1),
                  tl: {
                    hd: S.fontSize(1),
                    tl: {
                      hd: S.flexBasis({
                            NAME: "pct",
                            VAL: 100
                          }),
                      tl: {
                        hd: S.letterSpacing(0.5),
                        tl: {
                          hd: S.lineHeight(Core.Styles.getLineHeight(0, 1, undefined)),
                          tl: /* [] */0
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    });

function TextArea(Props) {
  var onChangeText = Props.onChangeText;
  var value = Props.value;
  return React.createElement(ReactNative.TextInput, {
              autoCorrect: true,
              multiline: true,
              onChangeText: onChangeText,
              spellCheck: true,
              value: value,
              style: style
            });
}

var make = TextArea;

export {
  style ,
  make ,
  
}
/* style Not a pure module */
