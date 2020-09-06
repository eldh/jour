let diaryFolder = Fs.documentDirectoryPath ++ "/.diary";

let ensureFolderExists = folder =>
  Fs.exists(folder)
  ->Promise.flatMap(exists =>
      exists ? Promise.resolved(Ok()) : Fs.mkdir(folder)
    );

let writeToFile = (~file, ~contents, ~folder=diaryFolder, ()) => {
  ensureFolderExists(folder)
  ->Promise.flatMapOk(() => {
      Fs.writeFile(~filepath=folder ++ "/" ++ file, ~contents, ())
    });
};

let getFilenameForDate = d => {
  DateFns.format(d, "yyyy-MM-dd") ++ ".md";
};

let validateFilename = str => {
  Js.String.match(Js.Re.fromString("\d{4}-\d{2}-\d{2}\.md"), str)
  ->Belt.Option.map(Belt.Array.getExn(_, 0));
};

let validFilenameToDate = str => {
  let subStr = String.sub(str);
  let year = subStr(0, 4);
  let month = subStr(5, 2);
  let day = subStr(8, 2);

  Js.Date.fromString([|year, month, day|]->Js.Array.joinWith("-", _));
};

let createEntryFromReadDirInfo = (entry: Fs.readDirItem) => {
  entry.name
  ->validateFilename
  ->Belt.Option.map(name => (name, validFilenameToDate(name)));
};

let getDiaryEntries = () => {
  Fs.(readDir(documentDirectoryPath ++ "/.diary"))
  ->Promise.mapOk(entries => {
      entries
      ->Belt.Array.map(createEntryFromReadDirInfo)
      ->Belt.Array.keepMap(z => z)
      ->Belt.List.fromArray
    });
};

let writeDiaryToFs = (~date, ~contents, ()) => {
  writeToFile(~file="test-" ++ getFilenameForDate(date), ~contents, ());
};
