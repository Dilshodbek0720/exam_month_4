import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_repo_n8/data/firebase/users_service.dart';
import 'package:exam_repo_n8/data/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import '../data/models/universal_data.dart';
import '../utils/ui_utils/loading_dialog.dart';

class UserProvider with ChangeNotifier {
  UserProvider({required this.userService});

  final UserService userService;
  int selectedRole = 0;



  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  void selectRole({required int userRole}){
    selectedRole = userRole;
    notifyListeners();
  }

  Future<void> addUser({required BuildContext context, required int userRole, required String fcmToken}) async {
    String firstname = firstnameController.text;
    String lastname = lastnameController.text;
    int age = int.parse(ageController.text);
    String fcmToken = "";

    if (firstname.isNotEmpty && firstname.isNotEmpty && lastname.isNotEmpty) {
      UserModel userModel = UserModel(
        userId: "",
        firstname: firstname,
        lastname: lastname,
        age: age,
        fcm: fcmToken,
        userRole: userRole,
        createdAt: DateTime.now().toString(),
      );
      showLoading(context: context);
      UniversalData universalData =
          await userService.addUser(userModel: userModel);
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
          clearTexts();
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    } else {
      showMessage(context, "Maydonlar to'liq emas!!!");
    }
  }

  Future<void> updateUser({
    required BuildContext context,
    required UserModel userModel,
  }) async {
    String firstname = firstnameController.text;
    String lastname = lastnameController.text;
    int age = int.parse(ageController.text);

    // if (categoryUrl.isEmpty) categoryUrl = currentCategory.imageUrl;

    if (firstname.isNotEmpty && lastname.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData = await userService.updateUser(
          userModel: UserModel(
        firstname: firstname,
        lastname: lastname,
        age: age,
        userId: userModel.userId,
        fcm: "1313",
        userRole: 0,
        createdAt: DateTime.now().toString(),
      ));
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
          clearTexts();
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    }
  }

  Future<void> deleteUser({
    required BuildContext context,
    required String userId,
  }) async {
    showLoading(context: context);
    UniversalData universalData = await userService.deleteUser(userId: userId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<List<UserModel>> getUsers() =>
      FirebaseFirestore.instance.collection("users").snapshots().map(
            (event1) => event1.docs
                .map((doc) => UserModel.fromJson(doc.data()))
                .toList(),
          );

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }

  setInitialValues(UserModel userModel) {
    firstnameController = TextEditingController(text: userModel.firstname);
    lastnameController = TextEditingController(text: userModel.lastname);
    ageController = TextEditingController(text: userModel.age.toString());
    // notifyListeners();
  }

  clearTexts() {
    lastnameController.clear();
    firstnameController.clear();
    ageController.clear();
  }
}
