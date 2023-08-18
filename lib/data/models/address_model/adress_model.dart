class AddressModelFields {
  static const String id = "_id";
  static const String tableName = "tables";
  static const String address = "address";
  static const String padez = "padez";
  static const String etaj = "etaj";
  static const String kvartira = "kvartira";
  static const String manzil = "manzil";
  static const String lat = "lat";
  static const String long = "long";
}

class AddressModel {
  int? id;
  final String address;
  final String padez;
  final String etaj;
  final String kvartira;
  final String manzil;
  final String lat;
  final String long;

  AddressModel({required this.manzil, required this.kvartira, required this.etaj, required this.padez,this.id,required this.address, required this.lat, required this.long});


  AddressModel copyWith({
    String? address,
    String? padez,
    String? etaj,
    String? kvartira,
    String? manzil,
    String? lat,
    String? long,
    int? id,
  }) {
    return AddressModel(
      address: address ?? this.address,
      padez: padez ?? this.padez,
      etaj: etaj ?? this.etaj,
      kvartira: kvartira ?? this.kvartira,
      manzil: manzil ?? this.manzil,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      id: id ?? this.id,
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'],
      padez: json['padez'],
      etaj: json['etaj'],
      kvartira: json['kvartira'],
      manzil: json['manzil'],
      lat: json['lat'],
      long: json['long'],
      id: json[AddressModelFields.id] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AddressModelFields.address: address,
      AddressModelFields.padez: padez,
      AddressModelFields.etaj: etaj,
      AddressModelFields.kvartira: kvartira,
      AddressModelFields.manzil: manzil,
      AddressModelFields.lat: lat,
      AddressModelFields.long: long,
    };
  }
}
