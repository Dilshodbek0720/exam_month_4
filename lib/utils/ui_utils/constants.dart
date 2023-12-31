import 'package:google_maps_flutter/google_maps_flutter.dart';
const String adminEmail = "admin@gmail.com";

const defaultImageConstant = "Select Image";

const baseUrl = "https://geocode-maps.yandex.ru";
const String apiKey = "0966317a-0c56-4ae7-a7ee-eda74212af4d";

class TimeOutConstants {
  static int connectTimeout = 30;
  static int receiveTimeout = 25;
  static int sendTimeout = 60;
}

const List<String> langList = [
  "uz_UZ",
  "ru_RU",
  "en_GB",
  "tr_TR",
];

Map<String, String> language = {
  "uz_UZ" : "Uzbek",
  "ru_RU" : "Rus",
  "en_GB" : "Ingliz",
  "tr_TR" : "Turk"
};