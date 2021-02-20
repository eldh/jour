// Consts
@module("react-native-fs")
external mainBundlePath: string = "MainBundlePath"
@module("react-native-fs")
external cachesDirectoryPath: string = "CachesDirectoryPath"
@module("react-native-fs")
external externalCachesDirectoryPath: string = "ExternalCachesDirectoryPath"
@module("react-native-fs")
external downloadDirectoryPath: string = "DownloadDirectoryPath"
@module("react-native-fs")
external documentDirectoryPath: string = "DocumentDirectoryPath"
@module("react-native-fs")
external externalDirectoryPath: string = "ExternalDirectoryPath"
@module("react-native-fs")
external externalStorageDirectoryPath: string = "ExternalStorageDirectoryPath"
@module("react-native-fs")
external temporaryDirectoryPath: string = "TemporaryDirectoryPath"
@module("react-native-fs")
external libraryDirectoryPath: string = "LibraryDirectoryPath"
@module("react-native-fs")
external picturesDirectoryPath: string = "PicturesDirectoryPath"
@module("react-native-fs")
external fileProtectionKeys: string = "FileProtectionKeys"

type readDirItem = {
  ctime: option<Js.Date.t>, // The creation date of the file (iOS only)
  mtime: option<Js.Date.t>, // The last modified date of the file
  name: string, // The name of the item
  path: string, // The absolute path to the item
  size: string, // Size in bytes
  isFile: unit => bool, // Is the file just a file?
  isDirectory: unit => bool, // Is the file a directory?
}

@module("react-native-fs")
external __readDir: string => Promise.Js.t<array<readDirItem>, _> = "readDir"
let readDir = v => __readDir(v)->Promise.Js.toResult

@module("react-native-fs")
external exists: string => Promise.t<bool> = "exists"

@module("react-native-fs")
external __readFile: string => Promise.Js.t<string, _> = "readFile"
let readFile = (~filepath, ()) => __readFile(filepath)->Promise.Js.toResult

@module("react-native-fs")
external __readFileWithOptions: (string, {..}) => Promise.Js.t<string, _> = "readFile"
let readFileWithOptions = (v, o) => __readFileWithOptions(v, o)->Promise.Js.toResult

type statResult = {
  name: option<string>, // The name of the item TODO: why is this not documented?
  path: string, // The absolute path to the item
  size: string, // Size in bytes
  mode: float, // UNIX file mode
  ctime: float, // Created date
  mtime: float, // Last modified date
  originalFilepath: string, // In case of content uri this is the pointed file path, otherwise is the same as path
  isFile: unit => bool, // Is the file just a file?
  isDirectory: unit => bool, // Is the file a directory?
}

@module("react-native-fs")
external __stat: string => Promise.Js.t<statResult, _> = "stat"
let stat = v => __stat(v)->Promise.Js.toResult

@module("react-native-fs")
external __mkdir: string => Promise.Js.t<unit, _> = "mkdir"
let mkdir = v => __mkdir(v)->Promise.Js.toResult

@module("react-native-fs")
external __writeFile: (
  ~filepath: string,
  ~contents: string,
  ~encodingOrOptions: option<{..}>=?,
  unit,
) => Promise.Js.t<unit, _> = "writeFile"
let writeFile = (~filepath, ~contents, ~encodingOrOptions=?, ()) =>
  __writeFile(~filepath, ~contents, ~encodingOrOptions?, ())->Promise.Js.toResult

@module("react-native-fs")
external __appendFile: (
  ~filepath: string,
  ~contents: string,
  ~encodingOrOptions: option<{..}>=?,
  unit,
) => Promise.Js.t<unit, _> = "appendFile"
let appendFile = (~filepath, ~contents, ~encodingOrOptions=?, ()) =>
  __appendFile(~filepath, ~contents, ~encodingOrOptions?, ())->Promise.Js.toResult

@module("react-native-fs")
external __write: (
  ~filepath: string,
  ~contents: string,
  ~position: int=?,
  ~encodingOrOptions: {..}=?,
  unit,
) => Promise.Js.t<unit, _> = "write"
let write = (~filepath, ~contents, ~position, ~encodingOrOptions=?, ()) =>
  __write(~filepath, ~contents, ~position, ~encodingOrOptions?, ())->Promise.Js.toResult
