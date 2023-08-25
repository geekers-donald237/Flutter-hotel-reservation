  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content:
  //             Text(AppLocalizations.of(context)!.location_service_disable)));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text(AppLocalizations.of(context)!.localization_denied)));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(AppLocalizations.of(context)!.denied_permently)));
  //     return false;
  //   }
  //   return true;
  // }

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();

  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     setState(() => _currentPosition = position);
  //     _getAddressFromLatLng(_currentPosition!);
  //   }).catchError((e) {
  //     // debugPrint(e);
  //   });
  // }

  // Future<void> _getAddressFromLatLng(Position position) async {
  //   position = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best)
  //       .timeout(Duration(seconds: 5));

  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );

  //     if (placemarks.isNotEmpty) {
  //       Placemark firstPlacemark = placemarks[0];
  //       name = firstPlacemark.name ?? "";
  //       street = firstPlacemark.street ?? "";
  //       country = firstPlacemark.country ?? "";
  //       countryCode = firstPlacemark.isoCountryCode ?? "";

  //       // Vous pouvez maintenant utiliser les variables name, street et country selon vos besoins.

  //       print("Name: $name");
  //       print("Street: $street");
  //       print("Country: $country");
  //     }
  //   } catch (err) {
  //     print("Error: $err");
  //   }
  // }



import 'package:flutter/material.dart';

//imported google's material design library
void main() {
runApp(
	/**Our App Widget Tree Starts Here**/
	MaterialApp(
	home: Scaffold(
	appBar: AppBar(
		title: const Text('GeeksforGeeks'),
		backgroundColor: Colors.greenAccent[400],
		centerTitle: true,
	), //AppBar
	body: Center(
		/** Card Widget **/
		child: Card(
		elevation: 50,
		shadowColor: Colors.black,
		color: Colors.greenAccent[100],
		child: SizedBox(
			width: 300,
			height: 500,
			child: Padding(
			padding: const EdgeInsets.all(20.0),
			child: Column(
				children: [
				CircleAvatar(
					backgroundColor: Colors.green[500],
					radius: 108,
					child: const CircleAvatar(
					backgroundImage: NetworkImage(
						"https://media.geeksforgeeks.org/wp-content/uploads/20210101144014/gfglogo.png"), //NetworkImage
					radius: 100,
					), //CircleAvatar
				), //CircleAvatar
				const SizedBox(
					height: 10,
				), //SizedBox
				Text(
					'GeeksforGeeks',
					style: TextStyle(
					fontSize: 30,
					color: Colors.green[900],
					fontWeight: FontWeight.w500,
					), //Textstyle
				), //Text
				const SizedBox(
					height: 10,
				), //SizedBox
				const Text(
					'GeeksforGeeks is a computer science portal for geeks at geeksforgeeks.org. It contains well written, well thought and well explained computer science and programming articles, quizzes, projects, interview experiences and much more!!',
					style: TextStyle(
					fontSize: 15,
					color: Colors.green,
					), //Textstyle
				), //Text
				const SizedBox(
					height: 10,
				), //SizedBox
				SizedBox(
					width: 100,

					child: ElevatedButton(
					onPressed: () => 'Null',
					style: ButtonStyle(
						backgroundColor:
							MaterialStateProperty.all(Colors.green)),
					child: Padding(
						padding: const EdgeInsets.all(4),
						child: Row(
						children: const [
							Icon(Icons.touch_app),
							Text('Visit')
						],
						),
					),
					),
					// RaisedButton is deprecated and should not be used
					// Use ElevatedButton instead

					// child: RaisedButton(
					// onPressed: () => null,
					// color: Colors.green,
					// child: Padding(
					//	 padding: const EdgeInsets.all(4.0),
					//	 child: Row(
					//	 children: const [
					//		 Icon(Icons.touch_app),
					//		 Text('Visit'),
					//	 ],
					//	 ), //Row
					// ), //Padding
					// ), //RaisedButton
				) //SizedBox
				],
			), //Column
			), //Padding
		), //SizedBox
		), //Card
	), //Center
	), //Scaffold
) //MaterialApp
	);
}


