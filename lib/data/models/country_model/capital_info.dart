class CapitalInfo {
  List<double>? latlng;

  CapitalInfo({
    this.latlng,
  });

  factory CapitalInfo.fromJson(Map<String, dynamic>? json) {
    // print(json);
    return CapitalInfo(
      latlng: json?["latlng"] == null
          ? null
          : (json?["latlng"] as List?)?.map((e) => e as double).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "latlng": latlng ?? [],
  };
}