import 'package:find_hotel/constants.dart';
import 'package:find_hotel/utils/network_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import '../gen/assets.gen.dart';
import '../gen/theme.dart';
import '../widgets/custom_apbar.dart';

class SearchLocalisationScreen extends StatefulWidget {
  const SearchLocalisationScreen({super.key});

  @override
  State<SearchLocalisationScreen> createState() =>
      _SearchLocalisationScreenState();
}

class _SearchLocalisationScreenState extends State<SearchLocalisationScreen> {
  void placeAutocomplete(String query) async {
    Uri uri =
        Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json", {
      "input": query,
      "key": apiKey,
    });

    String? response = await networkUtilitie.fetchUrl(uri);

    if (response != null) {
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbar('Set Delivery Location'),
      body: Column(children: [
        Form(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: TextFormField(
              onChanged: (value) {
                placeAutocomplete(value);
              },
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: "Search your Location",
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Assets.icon.location.svg(color: ColorName.blue),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kgrey, width: 2.0),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kgrey, width: 2.0),
                    borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: ElevatedButton.icon(
            onPressed: () {
              placeAutocomplete("Dubai");
            },
            icon: Icon(
              Icons.pin_drop_outlined,
              size: 20,
              color: ksecondryColor,
            ),
            label: Text('Use My Current Location'),
            style: ElevatedButton.styleFrom(
                backgroundColor: kwhite,
                foregroundColor: kblue,
                elevation: 1,
                fixedSize: Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)))),
          ),
        ),
        Divider(
          height: 4,
          thickness: 4,
          color: kblack,
        ),
        // LocationListTitle(
        //   press: () {},
        //   location: 'Indore India',
        // ),
        // LocationListTitle(
        //   press: () {},
        //   location: 'Test Result',
        // ),
      ]),
    );
  }
}
