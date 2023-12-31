import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/local/local_database.dart';
import '../data/models/address_model/adress_model.dart';

class LocationUserProvider with ChangeNotifier{

  TextEditingController podezController = TextEditingController();
  TextEditingController etajController = TextEditingController();
  TextEditingController kvartiraController = TextEditingController();
  TextEditingController manzilController = TextEditingController();

  LocationUserProvider(){
    getLocationUser();
    notifyListeners();
  }


  List<AddressModel> locationUser=[];

  getLocationUser()async{
    locationUser = await LocalDatabase.getAllAddress();

    notifyListeners();
  }

  deleteLocationUser({required int id})async{
    await LocalDatabase.deleteAddress(id);
    await getLocationUser();
    notifyListeners();
  }

  updateLocationUser({required AddressModel addressModel})async{
    await LocalDatabase.updateAddress(addressModel: addressModel);
    await getLocationUser();
    notifyListeners();
  }

  insertLocationUser({required AddressModel addressModel})async{
    await LocalDatabase.insertAddress(addressModel);
    await getLocationUser();
    notifyListeners();
  }

  clearText(){
    podezController.clear();
    etajController.clear();
    kvartiraController.clear();
    manzilController.clear();
  }

  String toast = "Malumotlarni to'liq kiriting!";

  String isCreate(){
    if(podezController.text.isNotEmpty && etajController.text.isNotEmpty && kvartiraController.text.isNotEmpty && manzilController.text.isNotEmpty){
      toast = "Malumotlar to'liq kiritildi";
      return toast;
    }else{
      toast = "Malumotlarni to'liq kiriting!";
      return toast;
    }
  }

}