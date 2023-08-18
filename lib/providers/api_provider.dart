import 'package:exam_repo_n8/data/models/universal_data.dart';
import 'package:flutter/material.dart';
import '../data/models/country_model/country_model.dart';
import '../data/network/api_service.dart';

class ApiProvider with ChangeNotifier {
  ApiProvider({required this.apiService}){
    getAllCountry();
    notifyListeners();
  }

  final ApiService apiService;
  bool isLoading = false;

  List<CountryModel> countries = [];

  getAllCountry() async {
    isLoading = true;
    UniversalData universalData = await apiService.getAllCountries();
    if (universalData.error.isEmpty) {
      countries = universalData.data;
    } else {
      debugPrint("ERROR:${universalData.error}");
    }
    isLoading = false;
    notifyListeners();
  }
}