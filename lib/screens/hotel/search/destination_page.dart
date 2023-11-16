import 'dart:io';

import 'package:find_hotel/gen/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../providers/utils_provider.dart';


class Test extends ConsumerWidget {
  Test({super.key});

  String location = 'Null, Press Button';



  // storeDestinationInfo(String Destination) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('destination', Destination);
  // }

  Future<Position> _getGeoLocationPosition() async {


    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(BuildContext context,Position position, WidgetRef ref) async {
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      EasyLoading.dismiss();
      ref.read(LongitudeProvider.notifier).update((state) => position.longitude);
      ref.read(LattitudeProvider.notifier).update((state) => position.longitude);
      if (kDebugMode) {
        print("dddididididi $placemarks");
      }
      if (kDebugMode) {
        print('latitude et longitude ${position.longitude}, ${position.latitude}');
      }
      ref.read(LocationCurrentProvider.notifier).update((state) => AppLocalizations.of(context)!.my_position);

      Navigator.of(context).pop();
    }on SocketException{
      EasyLoading.showInfo(AppLocalizations.of(context)!.verified_internet,
          duration: const Duration(seconds: 3));
    }catch(e){
      EasyLoading.showInfo(AppLocalizations.of(context)!.an_error_occur,
          duration: const Duration(seconds: 4));
    }

    // Placemark place = placemarks[0];
    // Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String destination = ref.watch(LocationCurrentProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        foregroundColor: kblack,
        elevation: 2,
        title: Text('Select one')
      ),
      body: Container(
        color: kwhite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: yellow.withOpacity(0.3), width: 4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                        hintText: AppLocalizations.of(context)!.destination_place),
                    autofocus: true,
                  ),
                ),
              ),
              SizedBox(height: 50,),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SearchOption(
                  title: AppLocalizations.of(context)!.autour_message,
                  icon: Ionicons.locate_outline,
                  textColor: kblue,
                  ontap: () async {
                    LocationPermission permission = await Geolocator.checkPermission();

                    if(permission == LocationPermission.denied){
                      //print(permission);
                      showDialog(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          child:  AlertDialog(
                              title: Center(child: Column(
                                children: [
                                  Icon(Icons.location_on),
                                  Center(child: Text(AppLocalizations.of(context)!.use_your_location,textAlign: TextAlign.center,)),
                                ],
                              )),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .message_of_acceptance_fine_coarse_location,
                                    style: TextStyle(color: Colors.black,fontSize: 14),textAlign: TextAlign.center,

                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .kitaboo_collect_data_to_shown_you,
                                    style: const TextStyle(color: Colors.black,fontSize: 14 ),textAlign: TextAlign.center,),
                                  SizedBox(height: 10,),
                                  Center(
                                    child: Image.asset('assets/image/map.png'),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                MaterialButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(AppLocalizations.of(context)!.denied_),
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    EasyLoading.show();
                                    destination = AppLocalizations.of(context)!.my_position;
                                    ref
                                        .read(LocationCurrentProvider.notifier)
                                        .update((state) => destination);

                                    Position position = await _getGeoLocationPosition();
                                    location =
                                    'Lat: ${position.latitude} , Long: ${position.longitude}';

                                    GetAddressFromLatLong(context,position, ref);
                                  },
                                  child: Text(AppLocalizations.of(context)!.accept_),
                                ),
                              ]),
                        ),
                      );
                    }else if(permission == LocationPermission.deniedForever){
                      showDialog(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          child:  AlertDialog(
                              title: Text(AppLocalizations.of(context)!.attention_),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .message_of_acceptance_fine_coarse_location,
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                              actions: <Widget>[
                                MaterialButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(AppLocalizations.of(context)!.denied_),
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    EasyLoading.show();
                                    destination = AppLocalizations.of(context)!.my_position;
                                    ref
                                        .read(LocationCurrentProvider.notifier)
                                        .update((state) => destination);

                                    Position position = await _getGeoLocationPosition();
                                    location =
                                    'Lat: ${position.latitude} , Long: ${position.longitude}';

                                    GetAddressFromLatLong(context,position, ref);
                                  },
                                  child: Text(AppLocalizations.of(context)!.accept_),
                                ),
                              ]),
                        ),
                      );
                    }else if(permission == LocationPermission.unableToDetermine){
                      showDialog(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          child:  AlertDialog(
                              title: Text(AppLocalizations.of(context)!.attention_),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .message_of_acceptance_fine_coarse_location,
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                              actions: <Widget>[
                                MaterialButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(AppLocalizations.of(context)!.denied_),
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    EasyLoading.show();
                                    destination = AppLocalizations.of(context)!.my_position;
                                    ref
                                        .read(LocationCurrentProvider.notifier)
                                        .update((state) => destination);

                                    Position position = await _getGeoLocationPosition();
                                    location =
                                    'Lat: ${position.latitude} , Long: ${position.longitude}';

                                    GetAddressFromLatLong(context,position, ref);

                                  },
                                  child: Text(AppLocalizations.of(context)!.accept_),
                                ),
                              ]),
                        ),
                      );
                    }
                    else{
                      EasyLoading.show();
                      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                      location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
                      //print(position);
                       GetAddressFromLatLong(context,position, ref);

                    }
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor = kblue;
  final Color textColor;
  final VoidCallback ontap;

  const SearchOption({
    required this.title,
    this.subtitle = "",
    required this.icon, // Valeur par défaut de l'icône
    Key? key,
    required this.textColor,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        borderOnForeground: true,
        surfaceTintColor: Colors.blue,
        shadowColor: Colors.grey.withOpacity(1),
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: blueClear.withOpacity(0.2),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 40,
                ),
              ),
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: kblack,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
