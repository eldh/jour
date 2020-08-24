let diaryFolder = Fs.documentDirectoryPath ++ "/.diary";

let ensureFolderExists = folder =>
  Fs.exists(folder)
  ->Promise.flatMap(exists =>
      exists ? Promise.resolved(Ok()) : Fs.mkdir(folder)
    );

let writeToFile = (~file, ~contents, ~folder=diaryFolder, ()) => {
  ensureFolderExists(folder)
  ->Promise.flatMapOk(() => {
      Js.log2("ok", "ok");

      Fs.writeFile(~filepath=folder ++ "/" ++ file, ~contents, ());
    });
};

let getFilenameForDate = d => {
  DateFns.format(d, "yyyy-MM-dd") ++ ".md";
};

let filenameToDate = str => {
  let subStr = String.sub(str);
  let year = subStr(0, 4);
  let month = subStr(5, 2);
  let day = subStr(8, 2);

  Js.Date.fromString([|year, month, day|]->Js.Array.joinWith("-", _));
};

let createEntryFromReadDirInfo = (entry: Fs.readDirItem) => (
  entry.name,
  filenameToDate(entry.name),
);

let getDiaryEntries = () => {
  Fs.(readDir(documentDirectoryPath ++ "/.diary"))
  ->Promise.mapOk(entries => {
      entries->Belt.Array.map(createEntryFromReadDirInfo)
    });
};

let writeDiaryToFs = (~date, ~contents, ()) => {
  writeToFile(~file="test-" ++ getFilenameForDate(date), ~contents, ());
};
