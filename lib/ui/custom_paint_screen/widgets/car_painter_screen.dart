import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/colors.dart';
import 'car_painter.dart';

class CarPainterScreen extends StatefulWidget {
  const CarPainterScreen({super.key});

  @override
  State<CarPainterScreen> createState() => _CarPainterScreenState();
}

class _CarPainterScreenState extends State<CarPainterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text("Car Painter Screen", style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
          color: AppColors.C_01AA4F,
        ),),
      ),
      body: Center(
        child: Container(
          child: CustomPaint(
            size: Size(500.w,400.h),
            painter: CarPainter(),
          ),
        ),
      ),
    );
  }
}
