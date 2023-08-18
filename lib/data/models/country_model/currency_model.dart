class Currency {
  String? name;
  String? symbol;

  Currency({
    this.name,
    this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    name: json["name"],
    symbol: json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "symbol": symbol,
  };
}