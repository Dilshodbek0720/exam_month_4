import 'package:exam_repo_n8/data/models/user_model/user_model.dart';
import 'package:exam_repo_n8/providers/users_provider.dart';
import 'package:exam_repo_n8/ui/users_screen/widgets/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/icons.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text("User Screen", style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
          color: AppColors.C_01AA4F,
        ),),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UserAddScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: context.read<UserProvider>().getUsers(),
        builder: (BuildContext context,
            AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
              children: List.generate(
                snapshot.data!.length,
                    (index) {
                      UserModel userModel = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: AppColors.C_01AA4F.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.r)
                    ),
                    child: ListTile(
                      onLongPress: () {
                        context.read<UserProvider>().deleteUser(
                          context: context,
                          userId: userModel.userId,
                        );
                      },
                      title: Text(userModel.firstname),
                      subtitle: Text(userModel.lastname+ "  " +userModel.fcm),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UserAddScreen(
                                  userModel: userModel,
                                );
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  );
                },
              ),
            )
                : Center(child: Lottie.asset(AppIcons.emptyLottie));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}