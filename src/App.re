Core.(
  setTheme(
    createTheme(
      ~baseFontSize=14,
      ~fontScale=1.25,
      ~baseLightness=60.,
      ~baseGridUnit=4,
      ~borderRadii={small: 2, medium: 4, large: 6},
      ~fonts={
        body: ["System"],
        title: ["System"],
        mono: ["Menlo"],
        alt: ["System"],
      },
      ~hues={
        primary: `rgb((18, 120, 240)) |> Lab.fromRGB,
        secondary: `rgb((100, 100, 100)) |> Lab.fromRGB,
        warning: `rgb((214, 135, 5)) |> Lab.fromRGB,
        success: `rgb((44, 173, 2)) |> Lab.fromRGB,
        error: `rgb((230, 26, 26)) |> Lab.fromRGB,
        brand1: `rgb((213, 54, 222)) |> Lab.fromRGB,
        brand2: `rgb((54, 213, 222)) |> Lab.fromRGB,
        body: `lab((3., 0., 0., 1.)),
        bodyUp1: `lab((15., 0., 0., 1.)),
        bodyUp2: `lab((20., 0., 0., 1.)),
        bodyUp3: `lab((25., 0., 0., 1.)),
        bodyDown1: `lab((2., 0., 0., 1.)),
        bodyDown2: `lab((1., 0., 0., 1.)),
        bodyDown3: `lab((0., 0., 0., 1.)),
        bodyText: `lab((80., 0., 0., 1.)),
        neutral: `rgb((40, 40, 40)) |> Lab.fromRGB,
        quiet: `rgb((130, 130, 130)) |> Lab.fromRGB,
      },
      ~gridWidth=700,
      (),
    ),
  )
);
let style =
  S.[
    backgroundColor(`body),
    width(`pct(100)),
    flex(1.),
    flexGrow(1.),
    padding(Some(`double)),
  ]
  ->S.make;
[@react.component]
let make = () => {
  <ReactNative.View style> <Editor /> </ReactNative.View>;
};
