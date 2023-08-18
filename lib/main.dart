import 'package:exam_repo_n8/data/firebase/users_service.dart';
import 'package:exam_repo_n8/data/network/api_service.dart';
import 'package:exam_repo_n8/data/network/map_api_service.dart';
import 'package:exam_repo_n8/providers/address_call_provider.dart';
import 'package:exam_repo_n8/providers/api_provider.dart';
import 'package:exam_repo_n8/providers/location_provider.dart';
import 'package:exam_repo_n8/providers/location_user_provider.dart';
import 'package:exam_repo_n8/providers/tab_box_provider.dart';
import 'package:exam_repo_n8/providers/users_provider.dart';
import 'package:exam_repo_n8/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TabBoxProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => LocationUserProvider()),
        ChangeNotifierProvider(create: (context) => AddressCallProvider(apiService: MapApiService())),
        ChangeNotifierProvider(create: (context) => UserProvider(userService: UserService())),
        ChangeNotifierProvider(create: (context) => ApiProvider(apiService: ApiService())),
      ],
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}