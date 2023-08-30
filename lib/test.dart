// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class HomePage extends StatefulWidget {
// const HomePage({Key? key}) : super(key: key);

// @override
// _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
// Completer<GoogleMapController> _controller = Completer();
// // on below line we have specified camera position
// static final CameraPosition _kGoogle = const CameraPosition(
// 	target: LatLng(20.42796133580664, 80.885749655962),
// 	zoom: 14.4746,
// );

// // on below line we have created the list of markers
// final List<Marker> _markers = <Marker>[
// 	Marker(
// 		markerId: MarkerId('1'),
// 	position: LatLng(20.42796133580664, 75.885749655962),
// 	infoWindow: InfoWindow(
// 		title: 'My Position',
// 	)
// ),
// ];

// // created method for getting user current location
// Future<Position> getUserCurrentLocation() async {
// 	await Geolocator.requestPermission().then((value){
// 	}).onError((error, stackTrace) async {
// 	await Geolocator.requestPermission();
// 	print("ERROR"+error.toString());
// 	});
// 	return await Geolocator.getCurrentPosition();
// }

// @override
// Widget build(BuildContext context) {
// 	return Scaffold(
// 	appBar: AppBar(
// 		backgroundColor: Color(0xFF0F9D58),
// 		// on below line we have given title of app
// 		title: Text("GFG"),
// 	),
// 	body: Container(
// 		child: SafeArea(
// 		// on below line creating google maps
// 		child: GoogleMap(
// 		// on below line setting camera position
// 		initialCameraPosition: _kGoogle,
// 		// on below line we are setting markers on the map
// 		markers: Set<Marker>.of(_markers),
// 		// on below line specifying map type.
// 		mapType: MapType.normal,
// 		// on below line setting user location enabled.
// 		myLocationEnabled: true,
// 		// on below line setting compass enabled.
// 		compassEnabled: true,
// 		// on below line specifying controller on map complete.
// 		onMapCreated: (GoogleMapController controller){
// 				_controller.complete(controller);
// 			},
// 		),
// 		),
// 	),
// 	// on pressing floating action button the camera will take to user current location
// 	floatingActionButton: FloatingActionButton(
// 		onPressed: () async{
// 		getUserCurrentLocation().then((value) async {
// 			print(value.latitude.toString() +" "+value.longitude.toString());

// 			// marker added for current users location
// 			_markers.add(
// 				Marker(
// 				markerId: MarkerId("2"),
// 				position: LatLng(value.latitude, value.longitude),
// 				infoWindow: InfoWindow(
// 					title: 'My Current Location',
// 				),
// 				)
// 			);

// 			// specified current users location
// 			CameraPosition cameraPosition = new CameraPosition(
// 			target: LatLng(value.latitude, value.longitude),
// 			zoom: 14,
// 			);

// 			final GoogleMapController controller = await _controller.future;
// 			controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
// 			setState(() {
// 			});
// 		});
// 		},
// 		child: Icon(Icons.local_activity),
// 	),
// 	);
// }
// }


// import 'package:find_hotel/utils/localfiles.dart';
// import 'package:find_hotel/widgets/app_text.dart';
// import 'package:find_hotel/widgets/custom_rating.dart';
// import 'package:flutter/material.dart';

// import 'gen/assets.gen.dart';
// import 'gen/theme.dart';



// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _index = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: SizedBox(
//           height: 400, // card height
//           child: PageView.builder(
//             itemCount: 10,
//             controller: PageController(viewportFraction: 0.7),
//             onPageChanged: (int index) => setState(() => _index = index),
//             itemBuilder: (_, i) {
//               return Transform.scale(
//                 scale: i == _index ? 1 : 0.9,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Flexible(
//                       flex: 2,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(12),
//                         ),
//                         child: Image.asset(
//                           Localfiles.OnboardImg2,
//                           width: double.maxFinite,
//                           fit: BoxFit.cover,
//                           height: 150, // Ajuster la hauteur de l'image
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Flexible(
//                       flex: 2,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             AppText.large(
//                               'hotel.title',
//                               fontSize: 18,
//                               textAlign: TextAlign.left,
//                               maxLine: 2,
//                               textOverflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 4),
//                             Row(
//                               children: [
//                                 Assets.icon.location.svg(
//                                   color: kgrey,
//                                   height: 15,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 AppText.small('hotel.location'),
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                               child: CustomRating(ratingScore: 5),
//                             ),
//                             RichText(
//                               text: TextSpan(
//                                 children: [
//                                   AppTextSpan.large('\$5555'),
//                                   AppTextSpan.medium(' /night'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class CarFeatureWidget extends StatelessWidget {
  final String title;
  final String value;

  CarFeatureWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Niveau d'élévation de la carte
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              value == 'On' ? Icons.check : Icons.close,
              color: value == 'On' ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

