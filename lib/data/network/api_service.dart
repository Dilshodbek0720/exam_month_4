import 'package:dio/dio.dart';
import 'package:exam_repo_n8/data/models/country_model/country_model.dart';
import 'package:flutter/cupertino.dart';
import '../models/universal_data.dart';

class ApiService {

  Future<UniversalData> getAllCountries() async {
    Response response;
    try {
      response = await Dio().get('https://restcountries.com/v3.1/all');
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        return UniversalData(data: (response.data as List<dynamic>?)
            ?.map((e) => CountryModel.fromJson(e))
            .toList() ??
            [],);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data);
      } else {
        debugPrint(e.toString());
        return UniversalData(error: e.message!);
      }
    }catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}