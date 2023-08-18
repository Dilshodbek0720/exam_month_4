import 'dart:async';
import 'package:exam_repo_n8/ui/map_screen/widgets/address_lang_selector.dart';
import 'package:exam_repo_n8/ui/map_screen/widgets/user_locations/user_locations.dart';
import 'package:exam_repo_n8/ui/users_screen/widgets/global_button.dart';
import 'package:exam_repo_n8/ui/users_screen/widgets/global_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../data/models/address_model/adress_model.dart';
import '../../providers/address_call_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/location_user_provider.dart';
import '../../utils/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.latLong});

  final LatLng latLong;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

Set<Marker> markers = {};

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;
  late CameraPosition currentCameraPosition;
  static CameraPosition currentPosition = CameraPosition(target: LatLng(41.26431679638257,69.23665791749954), zoom: 13);
  static CameraPosition initialPosition = CameraPosition(target: LatLng(41.27983980636389,69.23507642000915), zoom: 13);
  bool onCameraMoveStarted = false;
  MapType mapType = MapType.normal;

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();


  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      target: widget.latLong,
      zoom: 13,
    );

    currentCameraPosition = CameraPosition(
      target: widget.latLong,
      zoom: 13,
    );
    context.read<LocationProvider>().getLocation();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text("Google Map", style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
          color: AppColors.C_01AA4F,
        ),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const UserLocationsScreen();
            }));
          }, icon: const Icon(Icons.maps_ugc_sharp)),
          const SizedBox(width: 5,)
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            onCameraMove: (CameraPosition cameraPosition) {
              currentCameraPosition = cameraPosition;
            },
            onCameraIdle: () {
              debugPrint(
                  "CURRENT CAMERA POSITION: ${currentCameraPosition.target.latitude} ${currentCameraPosition.target.longitude}");
              context
                  .read<AddressCallProvider>()
                  .getAddressByLatLong(latLng: currentCameraPosition.target);
              setState(() {
                onCameraMoveStarted = false;
              });
              debugPrint("MOVE FINISHED");
            },
            liteModeEnabled: false,
            myLocationEnabled: false,
            padding: const EdgeInsets.all(16),
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            mapType: mapType,
            onCameraMoveStarted: () {
              setState(() {
                onCameraMoveStarted = true;
              });
              debugPrint("MOVE STARTED");
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: initialCameraPosition,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(
                context.watch<AddressCallProvider>().scrolledAddressText,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment(-0.95,0.72),
            child: AddressLangSelector(),
          ),
          Positioned(
              bottom: 15,
              left: MediaQuery.of(context).size.width/2-32,
              child: Visibility(
                visible: context.watch<AddressCallProvider>().canSaveAddress(),
                child: Container(
                    height: 64,
                    width: 64,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle
                    ),
                    child: IconButton(onPressed: (){
                      showBottomSheetDialog();
                    }, icon: const Icon(Icons.add, color: Colors.white,size: 30,),)),
              )),
          Align(
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: onCameraMoveStarted ? 52 : 45,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _followMe(cameraPosition: initialCameraPosition);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(24.r),
          height: MediaQuery.of(context).size.height*0.8,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              Text("Address dastavka", style: TextStyle(fontSize: 22.sp),),
              SizedBox(height: 10.h,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 6.w), child: GlobalTextField(hintText: "Podez", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: context.read<LocationUserProvider>().podezController)),
              SizedBox(height: 10.h,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 6.w), child: GlobalTextField(hintText: "Etaj", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: context.read<LocationUserProvider>().etajController)),
              SizedBox(height: 10.h,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 6.w), child: GlobalTextField(hintText: "Kvartira", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: context.read<LocationUserProvider>().kvartiraController)),
              SizedBox(height: 10.h,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 6.w), child: GlobalTextField(hintText: "Eng Yaqin Manzil", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: context.read<LocationUserProvider>().manzilController)),
              SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: GlobalButton(title: "Saved", onTap: () async{
                  if(context.read<LocationUserProvider>().isCreate() == "Malumotlar to'liq kiritildi"){
                    AddressCallProvider adp = Provider.of<AddressCallProvider>(context, listen: false);
                    context.read<LocationUserProvider>().insertLocationUser(addressModel: AddressModel(address: adp.scrolledAddressText, lat: currentCameraPosition.target.latitude.toString(), long: currentCameraPosition.target.longitude.toString(), padez: context.read<LocationUserProvider>().podezController.text, etaj: context.read<LocationUserProvider>().etajController.text, kvartira: context.read<LocationUserProvider>().kvartiraController.text,manzil: context.read<LocationUserProvider>().manzilController.text,),);
                    context.read<LocationUserProvider>().clearText();
                    Navigator.pop(context);
                  }else{
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("Malumotlar to'liq kiritilmadi!"),
                      );
                    });
                  }
                }),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _followMe({required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }
}