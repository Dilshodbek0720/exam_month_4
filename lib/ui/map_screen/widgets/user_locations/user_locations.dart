import 'package:exam_repo_n8/ui/map_screen/widgets/user_locations/widgets/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../providers/location_user_provider.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/icons.dart';

class UserLocationsScreen extends StatefulWidget {
  const UserLocationsScreen({super.key});

  @override
  State<UserLocationsScreen> createState() => _UserLocationsScreenState();
}

class _UserLocationsScreenState extends State<UserLocationsScreen> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocationUserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text("Location Screen", style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
          color: AppColors.C_01AA4F,
        ),),
      ),
      body: provider.locationUser.isNotEmpty ? ListView(
              children: List.generate(provider.locationUser.length, (index) =>
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return UpdateScreen(addressModel: provider.locationUser[index]);
                        }));
                      },
                      title: Text("Address:  ${provider.locationUser[index].address}", style: const TextStyle(fontSize: 20),),
                      subtitle: Text("Podez: ${provider.locationUser[index].padez} Etaj: ${provider.locationUser[index].etaj}"),
                      trailing: IconButton(onPressed: () async{
                        provider.deleteLocationUser(id: context.read<LocationUserProvider>().locationUser[index].id!);
                      }, icon: const Icon(Icons.delete, color: Colors.redAccent,size: 26,),),
                    ),
                  )
              ),
            ) : Center(child: Lottie.asset(AppIcons.emptyLottie))
    );
  }
}
