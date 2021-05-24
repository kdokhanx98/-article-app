class Articls {
  final String id;
  final String title;
  bool isChecked;

  Articls(this.id, this.title, this.isChecked);
}

List<Articls> myArticls = <Articls>[
  new Articls("1", "this title for testing ", false),
  new Articls("1", "this title for testing ", false),
  new Articls("1", "this title for testing ", false),
  new Articls("1", "this title for testing ", false),
  new Articls("1", "this title for testing ", false),
  new Articls("1", "this title for testing ", false),
  new Articls("1", "this title for testing ", false),
  new Articls("1", "this title for testing ", false),
  new Articls("1", "this title for testing ", false),
  new Articls("1", "this title for testing ", false),
  new Articls("1", "this title for testing ", false),
  new Articls("1", "this title for testing ", false),
];

List<Articls> get getMyArticls {
  return [...myArticls];
}

cleanData() {
  myArticls.clear();
  myArticls = <Articls>[
    new Articls("1", "this title for testing ", false),
    new Articls("1", "this title for testing ", false),
    new Articls("1", "this title for testing ", false),
    new Articls("1", "this title for testing ", false),
    new Articls("1", "this title for testing ", false),
    new Articls("1", "this title for testing ", false),
    new Articls("1", "this title for testing ", false),
    new Articls("1", "this title for testing ", false),
    new Articls("1", "this title for testing ", false),
    new Articls("1", "this title for testing ", false),
    new Articls("1", "this title for testing ", false),
    new Articls("1", "this title for testing ", false),
  ];
}
