// Generated by BUCKLESCRIPT, PLEASE EDIT WITH CARE

import * as Fs from "./Fs.bs.js";
import * as $$String from "bs-platform/lib/es6/string.js";
import * as DateFns from "./DateFns.bs.js";
import * as $$Promise from "reason-promise/src/js/promise.js";
import * as Belt_List from "bs-platform/lib/es6/belt_List.js";
import * as Belt_Array from "bs-platform/lib/es6/belt_Array.js";
import * as Belt_Option from "bs-platform/lib/es6/belt_Option.js";
import * as Caml_option from "bs-platform/lib/es6/caml_option.js";
import * as ReactNativeFs from "react-native-fs";

var diaryFolder = ReactNativeFs.DocumentDirectoryPath + "/.diary";

function ensureFolderExists(folder) {
  return $$Promise.flatMap(ReactNativeFs.exists(folder), (function (exists) {
                if (exists) {
                  return $$Promise.resolved({
                              TAG: /* Ok */0,
                              _0: undefined
                            });
                } else {
                  return Fs.mkdir(folder);
                }
              }));
}

function writeToFile(file, contents, folderOpt, param) {
  var folder = folderOpt !== undefined ? folderOpt : diaryFolder;
  return $$Promise.flatMapOk(ensureFolderExists(folder), (function (param) {
                return Fs.writeFile(folder + ("/" + file), contents, undefined, undefined);
              }));
}

function getFilenameForDate(d) {
  return DateFns.format(d, "yyyy-MM-dd") + ".md";
}

function validateFilename(str) {
  return Belt_Option.map(Caml_option.null_to_opt(str.match(new RegExp("\\d{4}-\\d{2}-\\d{2}\\.md"))), (function (__x) {
                return Belt_Array.getExn(__x, 0);
              }));
}

function validFilenameToDate(str) {
  var year = $$String.sub(str, 0, 4);
  var month = $$String.sub(str, 5, 2);
  var day = $$String.sub(str, 8, 2);
  return new Date([
                year,
                month,
                day
              ].join("-"));
}

function createEntryFromReadDirInfo(entry) {
  return Belt_Option.map(validateFilename(entry.name), (function (name) {
                return [
                        name,
                        validFilenameToDate(name)
                      ];
              }));
}

function getDiaryEntries(param) {
  return $$Promise.mapOk(Fs.readDir(ReactNativeFs.DocumentDirectoryPath + "/.diary"), (function (entries) {
                return Belt_List.fromArray(Belt_Array.keepMap(Belt_Array.map(entries, createEntryFromReadDirInfo), (function (z) {
                                  return z;
                                })));
              }));
}

function writeDiaryToFs(date, contents, param) {
  return writeToFile("test-" + getFilenameForDate(date), contents, undefined, undefined);
}

export {
  diaryFolder ,
  ensureFolderExists ,
  writeToFile ,
  getFilenameForDate ,
  validateFilename ,
  validFilenameToDate ,
  createEntryFromReadDirInfo ,
  getDiaryEntries ,
  writeDiaryToFs ,
  
}
/* diaryFolder Not a pure module */
