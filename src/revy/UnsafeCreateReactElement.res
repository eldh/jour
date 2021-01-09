@bs.module("react")
external createElement: (React.component<{..}>, {..}) => React.element = "createElement"

@react.component
let make = (~tag=ReactNative.View.make, ~props, ()) => createElement(tag, props)

let create = (tag, props) => createElement(tag, props)
