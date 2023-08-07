import 'package:find_hotel/routes/route_names.dart';
import 'package:find_hotel/utils/network_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import '../gen/theme.dart';
import '../widgets/custom_apbar.dart';

class SearchLocalisationScreen extends StatefulWidget {
  const SearchLocalisationScreen({super.key});

  @override
  State<SearchLocalisationScreen> createState() =>
      _SearchLocalisationScreenState();
}

const kGoogleApiKey = 'AIzaSyCiV9iwGdbgxbzJ5KrDfrHbKaE4MnHV5rg';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchLocalisationScreenState extends State<SearchLocalisationScreen> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14.0);

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;
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
      key: homeScaffoldKey,
      appBar: searchAppBar("Set Your Destination ", context),
      body: Column(children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: ElevatedButton.icon(
              onPressed: () {
                NavigationServices(context).gotoCurrentLocationScrenn();
              },
              icon: Icon(
                Icons.pin_drop_outlined,
                size: 20,
                color: ksecondryColor,
              ),
              label: Text('Nearby With me '),
              style: ElevatedButton.styleFrom(
                  backgroundColor: kwhite,
                  foregroundColor: kblue,
                  elevation: 1,
                  fixedSize: Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)))),
            ),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        // GoogleMap(
        //   initialCameraPosition: initialCameraPosition,
        //   markers: markersList,
        //   mapType: MapType.normal,
        //   onMapCreated: (GoogleMapController controller) {
        //     googleMapController = controller;
        //   },
        // ),
      ]),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [
          Component(Component.country, "pk"),
          Component(Component.country, "usa")
        ]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
