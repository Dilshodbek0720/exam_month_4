import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/location_provider.dart';
import '../tab_box.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return TabBox();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    if (locationProvider.latLong != null) {
      _init();
    }
    return Scaffold(
      body: Center(child: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          if (locationProvider.latLong == null) {
            return Text("LOCATION!!!", style: TextStyle(
              fontSize: 35.sp,
              fontWeight: FontWeight.w600
            ),);
          } else {
            return Text("");
          }
        },
      )),
    );
  }
}