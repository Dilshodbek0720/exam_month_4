class Car {
  List<String>? signs;
  String? side;

  Car({
    this.signs,
    this.side,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    signs: (json["signs"] as List?)?.map((e) => e as String).toList(),
    side: json["side"],
  );

  Map<String, dynamic> toJson() => {
    "signs": signs ?? [],
    "side": side,
  };
}