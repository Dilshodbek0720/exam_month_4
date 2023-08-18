class Name {
  String? common;
  String? official;
  Map<String, Translation>? nativeName;

  Name({
    this.common,
    this.official,
    this.nativeName,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    common: json["common"],
    official: json["official"],
    nativeName: (json['nativeName'] as Map?)?.map((key, value) =>
        MapEntry<String, Translation>(key, Translation.fromJson(value))),
  );

  Map<String, dynamic> toJson() {
    // print(nativeName);
    return {
      "common": common,
      "official": official,
      // "nativeName": Map.from(nativeName!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      "nativeName": nativeName?.map((key, value) => MapEntry(key, value.toJson())),

    };
  }
}

class Translation {
  String? official;
  String? common;

  Translation({
    this.official,
    this.common,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    official: json["official"],
    common: json["common"],
  );

  Map<String, dynamic> toJson() => {
    "official": official,
    "common": common,
  };
}