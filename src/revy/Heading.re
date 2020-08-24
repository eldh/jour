[@react.component]
let make =
    (
      ~level=`h1,
      ~style=?,
      ~color=`body,
      ~margin=`margin2((`noSpace, `noSpace)),
      ~children,
      (),
    ) => {
  let (size, weight) =
    switch (level) {
    | `h1 => (5, `bold)
    | `h2 => (4, `bold)
    | `h3 => (3, `bold)
    | `h4 => (2, `bold)
    | `h5 => (1, `bold)
    };

  <Text ?style size weight color > children </Text>;
};