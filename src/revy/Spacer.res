@react.component
let make = (~size as size_=#single, ()) => {
  let style = {
    open S
    list{marginBottom(size_)}
  }->S.make
  <View style> React.null </View>
}
