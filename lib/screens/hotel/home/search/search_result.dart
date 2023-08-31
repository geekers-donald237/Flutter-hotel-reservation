import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../gen/theme.dart';
import '../../../../models/hotel_model.dart';
import '../../../../providers/utils_provider.dart';

import '../../../../utils/helper.dart';
import '../../../../widgets/hotel_card.dart';
import '../../../../widgets/show_bottom_sheet.dart';

class SearchResultScreen extends ConsumerWidget {
  const SearchResultScreen({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    int accomodation = ref.watch(allAccomodationProvider);
    int adults = ref.watch(allAdultsProvider);
    int children = ref.watch(allChildrenProvider);
    String destination = ref.watch(LocationCurrentProvider);
    String dateTravel = ref.watch(StringDateProvider);
    bool isLoading = true;

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

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isLoading = false; // La charge est terminée
        });
      });
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: kblue,
          foregroundColor: kblack,
          elevation: 0.8,
          title: Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: yellow, width: 4),
                  borderRadius: BorderRadius.circular(2),
                  color: kwhite),
              width: double.infinity,
              child: Text.rich(
                TextSpan(
                  text: trimmedText,
                ),
              ),
            ),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10), // Ajout de l'espace horizontal
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Aligner les éléments aux extrémités
                        children: [
                          GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SortOptionsBottomSheet();
                                  },
                                );
                              },
                              child: _buildItem(
                                  AppLocalizations.of(context)!.item_trier,
                                  Icons.sort)),
                          _buildItem(AppLocalizations.of(context)!.item_filtrer,
                              Icons.filter_list),
                          _buildItem(AppLocalizations.of(context)!.item_carte,
                              Icons.map),
                        ],
                      ),
                    ),
                  ),

                  // Affiche le message "Chargement..." si la liste nearbyHotels est vide
                  if (nearbyHotels.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: nearbyHotels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    HotelModel hotel = nearbyHotels[index];
                                    return HotelCard(hotel: hotel);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (nearbyHotels.isEmpty) Text("Aucun hôtel trouvé"),
                ],
              ),
      );
    });
  }

  Widget _buildItem(String text, IconData icon) {
    return GestureDetector(
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 8), // Espace entre l'icône et le texte
          Text(text),
        ],
      ),
    );
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
