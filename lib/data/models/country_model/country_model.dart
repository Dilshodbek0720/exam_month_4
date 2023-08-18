import 'package:exam_repo_n8/data/models/country_model/postal_code.dart';

import 'capital_info.dart';
import 'car.dart';
import 'coat_off_arms.dart';
import 'currency_model.dart';
import 'flags.dart';
import 'idd.dart';
import 'maps.dart';
import 'name.dart';

class CountryModel {
  String? cca2;
  String? ccn3;
  String? cca3;
  String? cioc;
  bool? independent;
  String? status;
  bool? unMember;
  String? region;
  bool? landlocked;
  num? area;
  String? flag;
  int? population;
  String? fifa;
  String? startOfWeek;
  String? subregion;
  List<String>? tld;
  List<String>? capital;
  List<String>? altSpellings;
  List<num>? latlng;
  List<String>? borders;
  List<String>? timezones;
  List<String>? continents;
  PostalCode? postalCode;
  CapitalInfo? capitalInfo;
  CoatOfArms? coatOfArms;
  Flags? flags;
  Car? car;
  Maps? maps;
  Idd? idd;
  Name? name;
  Map<String, dynamic>? languages;
  Map<String, dynamic>? gini;
  Map<String, Currency>? currencies;

  CountryModel({
    this.cca2,
    this.ccn3,
    this.cca3,
    this.cioc,
    this.independent,
    this.status,
    this.unMember,
    this.region,
    this.landlocked,
    this.area,
    this.flag,
    this.population,
    this.fifa,
    this.startOfWeek,
    this.subregion,
    this.tld,
    this.capital,
    this.altSpellings,
    this.latlng,
    this.borders,
    this.timezones,
    this.continents,
    this.postalCode,
    this.capitalInfo,
    this.coatOfArms,
    this.flags,
    this.car,
    this.maps,
    this.idd,
    this.languages,
    this.gini,
    this.name,
    this.currencies,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      cca2: json["cca2"],
      ccn3: json["ccn3"],
      cca3: json["cca3"],
      cioc: json["cioc"],
      independent: json["independent"],
      status: json["status"],
      unMember: json["unMember"],
      region: json["region"],
      landlocked: json["landlocked"],
      area: json["area"],
      flag: json["flag"],
      population: json["population"],
      fifa: json["fifa"],
      startOfWeek: json["startOfWeek"],
      subregion: json["subregion"],
      tld: json["tld"] == null ? null : (json["tld"] as List?)?.map((e) => e as String).toList(),
      capital: json["capital"] == null
          ? null
          : (json["capital"] as List).map((e) => e as String).toList(),
      altSpellings: json["altSpellings"] == null
          ? null
          : (json["altSpellings"] as List).map((e) => e as String).toList(),
      latlng:
      json["latlng"] == null ? null : (json["latlng"] as List).map((e) => e as num).toList(),
      borders: json["borders"] == null
          ? null
          : (json["borders"] as List?)?.map((e) => e as String).toList() ?? [],
      timezones: json["timezones"] == null
          ? null
          : (json["timezones"] as List).map((e) => e as String).toList(),
      continents: json["continents"] == null
          ? null
          : (json["continents"] as List).map((e) => e as String).toList(),
      postalCode: PostalCode.fromJson(json["postalCode"]),
      capitalInfo: ((json["capitalInfo"] as Map).isEmpty)
          ? null
          : CapitalInfo.fromJson(json["capitalInfo"] as Map<String, dynamic>?),
      coatOfArms: ((json["coatOfArms"] as Map).isEmpty)
          ? null
          : CoatOfArms.fromJson(json["coatOfArms"] as Map<String, dynamic>?),
      flags: Flags.fromJson(json["flags"]),
      car: Car.fromJson(json["car"]),
      maps: Maps.fromJson(json["maps"]),
      idd: ((json["idd"] as Map).isEmpty) ? null : Idd.fromJson(json["idd"]),
      languages: json['languages'],
      gini: json['gini'],
      name: Name.fromJson(json["name"]),
      currencies: (json['currencies'] as Map?)
          ?.map((key, value) => MapEntry<String, Currency>(key, Currency.fromJson(value))),
    );
  }

  Map<String, dynamic> toJson() => {
    "cca2": cca2,
    "ccn3": ccn3,
    "cca3": cca3,
    "cioc": cioc,
    "independent": independent,
    "status": status,
    "unMember": unMember,
    "region": region,
    "landlocked": landlocked,
    "area": area,
    "flag": flag,
    "population": population,
    "fifa": fifa,
    "startOfWeek": startOfWeek,
    "subregion": subregion,
    "tld": tld ?? [],
    "capital": capital ?? [],
    "altSpellings": altSpellings ?? [],
    "latlng": latlng ?? [],
    "borders": borders ?? [],
    "timezones": timezones ?? [],
    "continents": continents ?? [],
    "postalCode": postalCode?.toJson(),
    "capitalInfo": capitalInfo?.toJson(),
    "coatOfArms": coatOfArms?.toJson(),
    "flags": flags?.toJson(),
    "car": car?.toJson(),
    "maps": maps?.toJson(),
    "idd": idd?.toJson(),
    'languages': languages,
    'gini': gini,
    "name": name?.toJson(),
    "currencies": currencies?.map((key, value) => MapEntry(key, value.toJson())),
  };
}