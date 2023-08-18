import 'package:exam_repo_n8/data/models/user_model/user_model.dart';
import 'package:exam_repo_n8/providers/users_provider.dart';
import 'package:exam_repo_n8/ui/users_screen/widgets/global_button.dart';
import 'package:exam_repo_n8/ui/users_screen/widgets/global_text_field.dart';
import 'package:exam_repo_n8/ui/users_screen/widgets/user_role_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../utils/colors.dart';
import '../../../data/firebase/fcm_service.dart';

class UserAddScreen extends StatefulWidget {
  UserAddScreen({super.key, this.userModel});

  UserModel? userModel;

  @override
  State<UserAddScreen> createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {

  @override
  void initState() {
    if (widget.userModel != null) {
      context.read<UserProvider>().setInitialValues(widget.userModel!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<UserProvider>(context, listen: false).clearTexts();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
          title: Text(
            widget.userModel == null ? "User Add" : "User Update",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              color: AppColors.C_01AA4F,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).clearTexts();
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.r),
                children: [
                  SizedBox(height: 14.h,),
                  GlobalTextField(
                      hintText: "FirstName",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      controller: context
                          .read<UserProvider>()
                          .firstnameController),
                  SizedBox(height: 28.h),
                  GlobalTextField(
                      hintText: "LastName",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      controller: context
                          .read<UserProvider>()
                          .lastnameController),
                  SizedBox(height: 28.h),
                  GlobalTextField(
                      hintText: "Age",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      controller: context
                          .read<UserProvider>()
                          .ageController),
                  SizedBox(height: 28.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UserRoleView(onTap: (){
                        context.read<UserProvider>().selectRole(userRole: 0);
                      }, selectedId: context.watch<UserProvider>().selectedRole == 0, userRoleText: "Admin"),
                      UserRoleView(onTap: (){
                        context.read<UserProvider>().selectRole(userRole: 1);
                      }, selectedId: context.watch<UserProvider>().selectedRole == 1, userRoleText: "Client"),
                      UserRoleView(onTap: (){
                        context.read<UserProvider>().selectRole(userRole: 2);
                      }, selectedId: context.watch<UserProvider>().selectedRole == 2, userRoleText: "Owner")
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: GlobalButton(
                  title: widget.userModel == null
                      ? "Add user"
                      : "Update user",
                  onTap: () async{
                    String? fcmToken = await FirebaseMessaging.instance.getToken();
                    debugPrint(fcmToken);
                    if (widget.userModel == null) {
                      context.read<UserProvider>().addUser(
                        context: context,
                        userRole: context.read<UserProvider>().selectedRole,
                        fcmToken: fcmToken!
                      );
                    } else {
                      context.read<UserProvider>().updateUser(
                          context: context,
                          userModel: widget.userModel!);
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}