import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_repo_n8/data/models/user_model/user_model.dart';

import '../models/universal_data.dart';

class UserService {
  Future<UniversalData> addUser(
      {required UserModel userModel}) async {
    try {
      DocumentReference newUser = await FirebaseFirestore.instance
          .collection("users")
          .add(userModel.toJson());

      await FirebaseFirestore.instance
          .collection("users")
          .doc(newUser.id)
          .update({
        "userId": newUser.id,
      });

      return UniversalData(data: "User added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateUser(
      {required UserModel userModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userModel.userId)
          .update(userModel.toJson());

      return UniversalData(data: "User updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteUser({required String userId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .delete();

      return UniversalData(data: "User deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}