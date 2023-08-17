import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../gen/theme.dart';
import '../models/hotel_model.dart';
import '../providers/all_accomodation.dart';
import '../providers/all_adults_provider.dart';
import '../providers/all_enfants_provider.dart';
import '../providers/all_hotels_provider.dart';
import '../providers/current_location.dart';
import '../providers/string_date_provider.dart';
import '../widgets/hotel_card.dart';

class SearchResultScreen extends ConsumerWidget {
  const SearchResultScreen({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    int accomodation = ref.watch(allAccomodationProvider);
    int adults = ref.watch(allAdultsProvider);
    int children = ref.watch(allChildrenProvider);
    String destination = ref.watch(LocationCurrentProvider);
    String dateTravel = ref.watch(StringDateProvider);

    final String originalText =
        '$destination - $accomodation chambres - ${children + adults} personnes';

    String trimmedText = originalText;
    const int maxLength = 20; // Définissez la longueur maximale souhaitée

    if (originalText.length > maxLength) {
      final String firstPart = originalText.substring(0, maxLength ~/ 2);
      final String lastPart =
          originalText.substring(originalText.length - (maxLength ~/ 2));
      trimmedText = '$firstPart.....  $lastPart';
    }

    final double targetLatitude = 48.8575;
    final double targetLongitude = 2.2949;

    List<HotelModel> nearbyHotels = findNearbyHotels(
        HotelModel.sampleHotels, targetLatitude, targetLongitude);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        foregroundColor: kblack,
        elevation: 0.8,
        title: Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: yellow.withOpacity(0.3), width: 4),
              borderRadius: BorderRadius.circular(2),
            ),
            width: double.infinity,
            child: Text.rich(
              TextSpan(
                text: trimmedText,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Affiche le message "Chargement..." si la liste nearbyHotels est vide
            if (nearbyHotels.isEmpty)
              CircularProgressIndicator()
            else if (nearbyHotels.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: nearbyHotels.length,
                  itemBuilder: (BuildContext context, int index) {
                    HotelModel hotel = nearbyHotels[index];
                    return HotelCard(hotel: hotel);
                  },
                ),
              ),
            if (nearbyHotels.isEmpty) Text("Aucun hôtel trouvé"),
          ],
        ),
      ),
    );
  }

  double deg2rad(double deg) {
    return deg * (3.141592653589793 / 180);
  }

  double getDistanceFromLatLonInKm(
      double lat1, double lon1, double lat2, double lon2) {
    final int R = 6371; // Rayon de la Terre en km
    final double dLat = deg2rad(lat2 - lat1);
    final double dLon = deg2rad(lon2 - lon1);
    final double a = (Math.sin(dLat / 2) * Math.sin(dLat / 2)) +
        (Math.cos(deg2rad(lat1)) *
            Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2));
    final double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    final double d = R * c; // Distance en km
    return d;
  }

  List<HotelModel> findNearbyHotels(List<HotelModel> hotelList,
      double targetLatitude, double targetLongitude) {
    final List<HotelModel> nearbyHotels = [];

    for (var hotel in hotelList) {
      final double distance = getDistanceFromLatLonInKm(
        targetLatitude,
        targetLongitude,
        hotel.coordinate.latitude,
        hotel.coordinate.longitude,
      );

      // if (distance <= 1.0) {
      //   // Moins de 1 km
      //   nearbyHotels.add(hotel);
      // }
      nearbyHotels.add(hotel);
    }

    return nearbyHotels;
  }
}
