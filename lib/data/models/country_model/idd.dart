class Idd {
  String? root;
  List<String>? suffixes;

  Idd({
    this.root,
    this.suffixes,
  });

  factory Idd.fromJson(Map<String, dynamic> json) => Idd(
    root: json["root"],
    suffixes: json["suffixes"] == null ? [] : List<String>.from(json["suffixes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "root": root,
    "suffixes": suffixes == null ? [] : List<dynamic>.from(suffixes!.map((x) => x)),
  };
}