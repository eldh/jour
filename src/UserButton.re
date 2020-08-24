[@react.component]
let make = () => {
  let user = UserMap.Context.useById(UserMap.baseUser.id);

  <ReactNative.TouchableOpacity
    onPress={_ => {
      UserMap.([Update(baseUser.id, IncreaseAge)] |> apply) |> ignore
    }}>
    {user->Belt.Option.mapWithDefault(React.null, user => {
       <ReactNative.View>
         <ReactNative.Text
           style={ReactNative.Style.style(~color="white", ())}>
           user.email->React.string
         </ReactNative.Text>
         <ReactNative.Text
           style={ReactNative.Style.style(~color="white", ())}>
           user.name->React.string
         </ReactNative.Text>
         <ReactNative.Text
           style={ReactNative.Style.style(~color="white", ())}>
           {user.age->string_of_int->React.string}
         </ReactNative.Text>
       </ReactNative.View>
     })}
  </ReactNative.TouchableOpacity>;
};
