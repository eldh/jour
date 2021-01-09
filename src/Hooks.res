let useInterval = (delay, callback: unit => unit, deps) => {
  let savedCallback = React.useRef(callback)

  React.useEffect1(() => {
    savedCallback.current = callback
    None
  }, [callback])

  React.useEffect1(() => {
    let handler = savedCallback.current

    let id = Js.Global.setInterval(handler, delay)
    Some(() => Js.Global.clearInterval(id))
  }, Array.concat(list{[delay], deps->Obj.magic}))
}
