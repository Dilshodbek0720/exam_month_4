import 'package:exam_repo_n8/ui/custom_paint_screen/widgets/car_painter_screen.dart';
import 'package:exam_repo_n8/utils/icons.dart';
import 'package:exam_repo_n8/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/colors.dart';

class CustomPaintScreen extends StatefulWidget {
  const CustomPaintScreen({super.key});

  @override
  State<CustomPaintScreen> createState() => _CustomPaintScreenState();
}

class _CustomPaintScreenState extends State<CustomPaintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            child: Column(
              children: [
                Stack(
          children: [
                CustomPaint(
                  size: Size(double.infinity, 350.h),
                  painter: MyPainter(),
                ),
                Positioned(
                    top: 120.h,
                    left: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 42.h,
                          width: 55.w,
                          child: SvgPicture.asset(AppIcons.icon),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "eCommerce Shop",
                          style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Container(
                          width: 228.w,
                          height: 1,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Text(
                          "Professional App for youre\nCommerce business",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white),
                        ),
                      ],
                    )),
          ],
        ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 280 / 926,
                  width: MediaQuery.of(context).size.width * 325 / 428,
                  child: Image.asset(AppImages.image),
                ),
                SizedBox(height: 35.h,),
                Text("Purchase Online !!", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 26.sp, color: AppColors.black),),
                SizedBox(height: 10.h,),
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing,\n                sed do eiusmod tempor ut labore", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14.sp, color: AppColors.black),),
                SizedBox(height: 15.h,),
              ],
            )),
        Positioned(
          right: 14.w,
            top: 42.h,
            child: TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return CarPainterScreen();
          }));
        }, child: Text("Car", style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
          color: AppColors.C_01AA4F,
        ),),)
        )
      ],
    ));
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = AppColors.C_037EEE.withOpacity(0.7);
    paint.strokeWidth = 2.0;

    var path = Path();

    path.moveTo(0, size.height * 0.87);
    path.quadraticBezierTo(
        size.width * 0.24, size.height, size.width * 0.66, size.height * 0.66);
    path.quadraticBezierTo(
        size.width * 0.66, size.height * 0.66, size.width, size.height * 0.4);
    path.lineTo(size.width, size.height * 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);

    Paint paint1 = Paint();
    paint1.color = AppColors.white.withOpacity(0.4);
    paint1.strokeWidth = 2.0;

    var path1 = Path();
    path1.moveTo(size.width * 0.42, 0);
    path1.quadraticBezierTo(size.width * 0.57, size.height * 0.55,
        size.width * 0.9, size.height * 0.55);
    path1.quadraticBezierTo(
        size.width, size.height * 0.6, size.width, size.height * 0.5);
    path1.quadraticBezierTo(
        size.width, size.height * 0.6, size.width, size.height * 0);
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
