import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../../data/models/address_model/adress_model.dart';
import '../../../../../providers/address_call_provider.dart';
import '../../../../../providers/location_user_provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../users_screen/widgets/global_button.dart';
import '../../../../users_screen/widgets/global_text_field.dart';
import '../../address_lang_selector.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required this.addressModel});

  final AddressModel addressModel;
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late CameraPosition initialCameraPosition;
  late CameraPosition currentCameraPosition;
  bool onCameraMoveStarted = false;
  MapType mapType = MapType.normal;

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      target: LatLng(double.parse(widget.addressModel.lat), double.parse(widget.addressModel.long)),
      zoom: 13,
    );

    currentCameraPosition = CameraPosition(
      target: LatLng(double.parse(widget.addressModel.lat), double.parse(widget.addressModel.long)),
      zoom: 13,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.black,
        title: const Text("Update Screen"),
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
                  "CURRENT CAMERA POSITION: ${currentCameraPosition.target.latitude}");
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
            zoomGesturesEnabled: false,
            zoomControlsEnabled: false,
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
                    child: IconButton(onPressed: () async{
                      showBottomSheetDialog();
                      // AddressCallProvider adp =
                      // Provider.of<AddressCallProvider>(context, listen: false);
                      // await context.read<LocationUserProvider>().updateLocationUser(addressModel: AddressModel(id: widget.addressModel.id,address: adp.scrolledAddressText, lat: currentCameraPosition.target.latitude.toString(), long: currentCameraPosition.target.longitude.toString()),);
                      // if(context.mounted) Navigator.pop(context);
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
          height: 600.h,
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
                child: GlobalButton(title: "Saved", onTap: (){
                  AddressCallProvider adp = Provider.of<AddressCallProvider>(context, listen: false);
                  context.read<LocationUserProvider>().updateLocationUser(addressModel: AddressModel(address: adp.scrolledAddressText, lat: currentCameraPosition.target.latitude.toString(), long: currentCameraPosition.target.longitude.toString(), padez: context.read<LocationUserProvider>().podezController.text, etaj: context.read<LocationUserProvider>().etajController.text, kvartira: context.read<LocationUserProvider>().kvartiraController.text,manzil: context.read<LocationUserProvider>().manzilController.text,),);
                  context.read<LocationUserProvider>().clearText();
                  Navigator.pop(context);
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