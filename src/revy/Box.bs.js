// Generated by BUCKLESCRIPT, PLEASE EDIT WITH CARE

import * as S from "./S.bs.js";
import * as Core from "./Core.bs.js";
import * as View from "./View.bs.js";
import * as React from "react";

function getBoxStyle(position_, align_, alignSelf_, alignContent_, backgroundColor_, grow_, basis_, wrap_, shrink_, justify_, direction_, padding_, margin_, height_, width_, maxWidth_, overflow_, borderRadius_, param) {
  return S.make({
              hd: S.width(width_),
              tl: {
                hd: S.maxWidth(maxWidth_),
                tl: {
                  hd: S.padding(padding_),
                  tl: {
                    hd: S.margin(margin_),
                    tl: {
                      hd: S.position(position_),
                      tl: {
                        hd: S.alignSelf(alignSelf_),
                        tl: {
                          hd: S.alignItems(align_),
                          tl: {
                            hd: S.backgroundColor(backgroundColor_),
                            tl: {
                              hd: S.alignContent(alignContent_),
                              tl: {
                                hd: S.height(height_),
                                tl: {
                                  hd: S.overflow(overflow_),
                                  tl: {
                                    hd: S.borderRadius(borderRadius_),
                                    tl: {
                                      hd: S.flexShrink(shrink_),
                                      tl: {
                                        hd: S.flexBasis(basis_),
                                        tl: {
                                          hd: S.flexDirection(direction_),
                                          tl: {
                                            hd: S.flexGrow(grow_),
                                            tl: {
                                              hd: S.flexWrap(wrap_),
                                              tl: {
                                                hd: S.justifyContent(justify_),
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
                          }
                        }
                      }
                    }
                  }
                }
              }
            });
}

function Box(Props) {
  Props.style;
  var positionOpt = Props.position;
  var alignOpt = Props.align;
  var alignSelfOpt = Props.alignSelf;
  var alignContentOpt = Props.alignContent;
  var backgroundColorOpt = Props.backgroundColor;
  var growOpt = Props.grow;
  var wrapOpt = Props.wrap;
  var shrinkOpt = Props.shrink;
  var basisOpt = Props.basis;
  var justifyOpt = Props.justify;
  var directionOpt = Props.direction;
  var padding = Props.padding;
  var margin = Props.margin;
  var heightOpt = Props.height;
  var widthOpt = Props.width;
  var maxWidthOpt = Props.maxWidth;
  var overflowOpt = Props.overflow;
  var borderRadiusOpt = Props.borderRadius;
  var children = Props.children;
  var position = positionOpt !== undefined ? positionOpt : /* relative */903134412;
  var align = alignOpt !== undefined ? alignOpt : /* flexStart */662439529;
  var alignSelf = alignSelfOpt !== undefined ? alignSelfOpt : /* auto */-1065951377;
  var alignContent = alignContentOpt !== undefined ? alignContentOpt : /* flexStart */662439529;
  var backgroundColor = backgroundColorOpt !== undefined ? backgroundColorOpt : /* transparent */582626130;
  var grow = growOpt !== undefined ? growOpt : 1;
  var wrap = wrapOpt !== undefined ? wrapOpt : /* wrap */-822134326;
  var shrink = shrinkOpt !== undefined ? shrinkOpt : 0;
  var basis = basisOpt !== undefined ? basisOpt : /* auto */-1065951377;
  var justify = justifyOpt !== undefined ? justifyOpt : /* flexStart */662439529;
  var direction = directionOpt !== undefined ? directionOpt : /* column */-963948842;
  var height = heightOpt !== undefined ? heightOpt : /* auto */-1065951377;
  var width = widthOpt !== undefined ? widthOpt : /* auto */-1065951377;
  var maxWidth = maxWidthOpt !== undefined ? maxWidthOpt : /* auto */-1065951377;
  var overflow = overflowOpt !== undefined ? overflowOpt : /* scroll */-949692403;
  var borderRadius = borderRadiusOpt !== undefined ? borderRadiusOpt : /* none */-922086728;
  var style = getBoxStyle(position, align, alignSelf, alignContent, backgroundColor, grow, basis, wrap, shrink, justify, direction, padding, margin, height, width, maxWidth, overflow, borderRadius, undefined);
  return React.createElement(Core.BackgroundColorContext.Provider.make, {
              value: backgroundColor,
              children: React.createElement(View.make, {
                    style: style,
                    children: children
                  })
            });
}

var make = Box;

export {
  getBoxStyle ,
  make ,
  
}
/* S Not a pure module */