let throttle = (~fn, ~timeout=1000) => {
  let throttling = ref(false);
  a =>
    if (! throttling^) {
      throttling := true;
      fn(a);
      Js.Global.setTimeout(() => throttling := false, timeout)->ignore;
    };
};
