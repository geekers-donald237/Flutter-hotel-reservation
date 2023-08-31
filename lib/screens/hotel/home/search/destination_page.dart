import 'package:find_hotel/gen/theme.dart';
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
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
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

  Future<void> GetAddressFromLatLong(Position position, WidgetRef ref) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    ref.read(LongitudeProvider.notifier).update((state) => position.longitude);

    ref.read(LattitudeProvider.notifier).update((state) => position.longitude);
    // print("dddididididi $placemarks");
    print('latitude et longitude ${position.longitude}, ${position.latitude}');
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
        title: Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
      ),
      body: Container(
        color: kwhite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchOption(
                title: AppLocalizations.of(context)!.autour_message,
                icon: Ionicons.locate_outline,
                textColor: kblue,
                ontap: () async {
                  EasyLoading.show(
                      status: AppLocalizations.of(context)!.loading);
                  destination = AppLocalizations.of(context)!.autour_message;
                  ref
                      .read(LocationCurrentProvider.notifier)
                      .update((state) => destination);

                  Position position = await _getGeoLocationPosition();
                  location =
                      'Lat: ${position.latitude} , Long: ${position.longitude}';
                  GetAddressFromLatLong(position, ref);
                  Navigator.of(context).pop();
                  EasyLoading.dismiss();
                },
              ),
              SizedBox(
                height: 10,
              ),
              // SearchOption(
              //   title: "Hebergement pour ce soir",
              //   subtitle: "Adresse du lieu",
              //   icon: Ionicons.locate_outline,
              //   textColor: kblue,
              //   ontap: () {},
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   padding: EdgeInsets.all(10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Option a proximite pour ce soir",
              //         style: Theme.of(context).textTheme.titleLarge,
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 10),
              // SearchOption(
              //   title: "EDEA FLAT",
              //   subtitle: "10 Juillet - 11 aout , 2 Adultes ",
              //   icon: Icons.history,
              //   textColor: kblack,
              //   ontap: () {},
              // ),
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
        shadowColor: Colors.grey.withOpacity(0.5),
        elevation: 0.5,
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
              SizedBox(width: 30),
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
                      style: TextStyle(
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
