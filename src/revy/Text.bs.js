// Generated by ReScript, PLEASE EDIT WITH CARE

import * as S from "./S.bs.js";
import * as Core from "./Core.bs.js";
import * as ReactNative from "react-native";
import * as Caml_exceptions from "bs-platform/lib/es6/caml_exceptions.js";
import * as UnsafeCreateReactElement from "./UnsafeCreateReactElement.bs.js";

var InvalidValue = Caml_exceptions.create("Text.InvalidValue");

function getTextStyles(extraStyleOpt, size, color_, quietOpt, tint, fontFamily_Opt, _textDecoration_Opt, lineHeight_, weight_, param) {
  var extraStyle = extraStyleOpt !== undefined ? extraStyleOpt : /* [] */0;
  var quiet = quietOpt !== undefined ? quietOpt : false;
  var fontFamily_ = fontFamily_Opt !== undefined ? fontFamily_Opt : "body";
  return S.make({
              hd: S.color(quiet ? -30 : undefined, tint, color_),
              tl: {
                hd: S.fontFamily(fontFamily_),
                tl: {
                  hd: S.lineHeight(Core.Styles.getLineHeight(size, lineHeight_, undefined)),
                  tl: {
                    hd: S.fontSize(size),
                    tl: {
                      hd: S.fontWeight(weight_),
                      tl: extraStyle
                    }
                  }
                }
              }
            });
}

function $$Text(Props) {
  var weightOpt = Props.weight;
  var colorOpt = Props.color;
  var sizeOpt = Props.size;
  var lineHeightOpt = Props.lineHeight;
  var textDecoration = Props.textDecoration;
  var fontFamily = Props.fontFamily;
  var quietOpt = Props.quiet;
  var tintColor = Props.tintColor;
  var style = Props.style;
  var children = Props.children;
  var weight = weightOpt !== undefined ? weightOpt : "normal";
  var color = colorOpt !== undefined ? colorOpt : "body";
  var size = sizeOpt !== undefined ? sizeOpt : 0;
  var lineHeight = lineHeightOpt !== undefined ? lineHeightOpt : 0;
  var quiet = quietOpt !== undefined ? quietOpt : false;
  var styles = getTextStyles(style, size, color, quiet, tintColor, fontFamily, textDecoration, lineHeight, weight, undefined);
  return UnsafeCreateReactElement.create(ReactNative.Text, {
              style: styles,
              children: children
            });
}

function Text$String(Props) {
  var weightOpt = Props.weight;
  var tagOpt = Props.tag;
  var sizeOpt = Props.size;
  var quietOpt = Props.quiet;
  var style = Props.style;
  var lineHeightOpt = Props.lineHeight;
  var textDecoration = Props.textDecoration;
  var colorOpt = Props.color;
  var tintColor = Props.tintColor;
  var children = Props.children;
  var weight = weightOpt !== undefined ? weightOpt : "normal";
  var tag = tagOpt !== undefined ? tagOpt : ReactNative.Text;
  var size = sizeOpt !== undefined ? sizeOpt : 0;
  var quiet = quietOpt !== undefined ? quietOpt : false;
  var lineHeight = lineHeightOpt !== undefined ? lineHeightOpt : 0;
  var color = colorOpt !== undefined ? colorOpt : "body";
  var styles = getTextStyles(style, size, color, quiet, tintColor, undefined, textDecoration, lineHeight, weight, undefined);
  return UnsafeCreateReactElement.create(tag, {
              style: styles,
              children: children
            });
}

var $$String = {
  make: Text$String
};

function Text$Block(Props) {
  var weightOpt = Props.weight;
  var tagOpt = Props.tag;
  var sizeOpt = Props.size;
  var quietOpt = Props.quiet;
  var style = Props.style;
  var lineHeightOpt = Props.lineHeight;
  var textDecoration = Props.textDecoration;
  var fontFamily = Props.fontFamily;
  var colorOpt = Props.color;
  var tintColor = Props.tintColor;
  var children = Props.children;
  var weight = weightOpt !== undefined ? weightOpt : "normal";
  var tag = tagOpt !== undefined ? tagOpt : ReactNative.Text;
  var size = sizeOpt !== undefined ? sizeOpt : 0;
  var quiet = quietOpt !== undefined ? quietOpt : false;
  var lineHeight = lineHeightOpt !== undefined ? lineHeightOpt : 0;
  var color = colorOpt !== undefined ? colorOpt : "body";
  var styles = getTextStyles(style, size, color, quiet, tintColor, fontFamily, textDecoration, lineHeight, weight, undefined);
  return UnsafeCreateReactElement.create(tag, {
              style: styles,
              children: children
            });
}

var Block = {
  make: Text$Block
};

var make = $$Text;

export {
  InvalidValue ,
  getTextStyles ,
  make ,
  $$String ,
  Block ,
  
}
/* S Not a pure module */
