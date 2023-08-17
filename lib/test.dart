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
