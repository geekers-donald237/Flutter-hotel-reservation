// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class TaxiScreen extends StatefulWidget {
//   const TaxiScreen({super.key});

//   @override
//   State<TaxiScreen> createState() => _TaxiScreenState();
// }

// class _TaxiScreenState extends State<TaxiScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

import 'package:find_hotel/gen/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String CurrentAddress = "";
  Position? _currentPosition;
  String name = "";
  String street = "";
  String country = '';
  String countryCode = '';

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(AppLocalizations.of(context)!.location_service_disable)));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.localization_denied)));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.denied_permently)));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .timeout(Duration(seconds: 5));

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks[0];
        name = firstPlacemark.name ?? "";
        street = firstPlacemark.street ?? "";
        country = firstPlacemark.country ?? "";
        countryCode = firstPlacemark.isoCountryCode ?? "";

        // Vous pouvez maintenant utiliser les variables name, street et country selon vos besoins.

        print("Name: $name");
        print("Street: $street");
        print("Country: $country");
      }
    } catch (err) {
      print("Error: $err");
    }
  }

  @override
  Widget build(BuildContext context) {
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
              decoration:
                  InputDecoration.collapsed(hintText: 'Search For A Resource'),
              autofocus: true,
            ),
          ),
        ),
      ),
      body: Container(
        color: kwhite,
        child: Column(
          children: [
            SizedBox(height: 5),
            SearchOption(
              title: "Proche de Votre Emplacement",
              icon: Ionicons.locate_outline,
              textColor: kblue,
              ontap: _getCurrentPosition,
            ),
            SizedBox(
              height: 10,
            ),
            SearchOption(
              title: "Hebergement pour ce soir",
              subtitle: "Adresse du lieu",
              icon: Ionicons.locate_outline,
              textColor: kblue,
              ontap: () {},
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Option a proximite pour ce soir",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SearchOption(
              title: "EDEA FLAT",
              subtitle: "10 Juillet - 11 aout , 2 Adultes ",
              icon: Icons.history,
              textColor: kblack,
              ontap: () {},
            ),
          ],
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
