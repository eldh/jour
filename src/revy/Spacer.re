[@react.component]
let make = (~size as size_=`single, ()) => {
  let style = S.[marginBottom(size_)]->S.make;
  <View style> React.null </View>;
};
