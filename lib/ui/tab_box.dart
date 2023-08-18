import 'package:exam_repo_n8/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:exam_repo_n8/ui/custom_paint_screen/custom_paint_screen.dart';
import 'package:exam_repo_n8/ui/users_screen/users_screen.dart';
import 'package:provider/provider.dart';
import '../providers/tab_box_provider.dart';
import 'country_screen/country_screen.dart';
import 'map_screen/map_screen.dart';


class TabBox extends StatefulWidget {
  const TabBox({super.key});


  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  @override
  void initState() {
    screens.add(const CountryScreen());
    screens.add(const UsersScreen());
    screens.add(MapScreen(latLong: context.read<LocationProvider>().latLong!,));
    screens.add(const CustomPaintScreen());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: context.watch<TabBoxProvider>().activeIndex,
        children: screens,
      ),
      backgroundColor: Colors.blue,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          context.read<TabBoxProvider>().changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), label: "Country"),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle_sharp, color: Colors.black,), label: "Users"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on, color: Colors.black,), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.edit, color: Colors.black,), label: "Custom"),
        ],
      ),
    );
  }

}