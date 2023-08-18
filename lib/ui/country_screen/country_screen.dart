import 'package:exam_repo_n8/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../data/models/country_model/country_model.dart';
import '../../utils/colors.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text("Country Screen", style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
          color: AppColors.C_01AA4F,
        ),),
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          CountryModel country = context.read<ApiProvider>().countries[index];
          return Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  country.flags!.png!,
                  width: MediaQuery.of(context).size.width*0.75,
                  height: MediaQuery.of(context).size.height*0.25,
                ),
                SizedBox(height: 16.h,),
                Text(
                  country.name!.official!,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Capital: ${country.capital?.join(", ")}',
                  style: const TextStyle(fontSize: 18),
                ),
                SizedBox(height: 7.h),
                Text(
                  'Region: ${country.region}',
                  style: const TextStyle(fontSize: 18),
                ),
                SizedBox(height: 7.h),
                Text(
                  'Population: ${country.population}',
                  style: const TextStyle(fontSize: 18),
                ),
                SizedBox(height: 7.h),
                Text(
                  'Language: ${country.languages?.values.toList()[0]}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
        itemCount: context.read<ApiProvider>().countries.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
