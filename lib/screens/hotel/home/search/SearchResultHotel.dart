import 'dart:io';
import 'dart:convert';
import 'package:find_hotel/gen/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import '../../../../api/encrypt.dart';
import '../../../../models/DestinationModel.dart';
import '../../../../models/hotel_model.dart';
import '../../../../urls/all_url.dart';
import '../../../../utils/helper.dart';
import '../../../../widgets/hotel_card.dart';
import '../../../../widgets/show_bottom_sheet.dart';

class SearchResultHotel extends StatefulWidget {
  const SearchResultHotel({
    super.key,
    required this.destination_1
  });

  final DestinationModel destination_1;

  @override
  State<SearchResultHotel> createState() => _SearchResultHotelState(destination_1);
}

class _SearchResultHotelState extends State<SearchResultHotel> {
  DestinationModel destination_1 = DestinationModel(
    destination: '',
    accomodation: 0,
    dateTravel: '',
    adults: 0,
    children: 0,
  );

// Vous pouvez maintenant utiliser 'emptyTravel' comme une instance vide de TravelDestination.

  _SearchResultHotelState(DestinationModel destination_1) {
    this.destination_1 = destination_1;
    super.initState();
  }

  String state = '0';

 Future<void> starting() async {
    try{
      var url = Uri.parse(Urls.hotel);
      final response = await http.post(url, body: {
        "destination": encrypt(destination_1.destination),
        "accomodation": encrypt(destination_1.accomodation.toString()),
        "action": encrypt('get_nearby_hotel'),
      });

      if(response.statusCode == 200){

      }else{
        
      }


    }on SocketException {
      EasyLoading.showInfo(AppLocalizations.of(context)!.verified_internet,
          duration: const Duration(seconds: 4));
    } catch (e) {
      EasyLoading.showInfo(AppLocalizations.of(context)!.an_error_occur,
          duration: const Duration(seconds: 4));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final double targetLatitude = 48.8575;
    final double targetLongitude = 2.2949;

    List<HotelModel> nearbyHotels = findNearbyHotels(
        HotelModel.sampleHotels, targetLatitude, targetLongitude);
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10), // Ajout de l'espace horizontal
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Aligner les éléments aux extrémités
                    children: [
                      _buildItem(
                          AppLocalizations.of(context)!.item_trier,
                          Icons.sort,
                          ontap:(){
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SortOptionsBottomSheet();
                              },
                            );
                          }
                      ),
                      _buildItem(AppLocalizations.of(context)!.item_filtrer,
                            Icons.filter_list,ontap:(){

                            }),

                      _buildItem(AppLocalizations.of(context)!.item_carte, Icons.map,
                          ontap:(){
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return const Text('ok');
                              },
                            );
                      }),
                  ],
                ),
              ),
            ),
            // Affiche le message "Chargement..." si la liste nearbyHotels est vide
            if (state == '0')
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
                            physics: const NeverScrollableScrollPhysics(),
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
      ]
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

  Widget _buildItem(String text, IconData icon,{required Function() ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 8), // Espace entre l'icône et le texte
          Text(text),
        ],
      ),
    );
  }
}

class ReservationWidget extends StatelessWidget {
  final String imagePath;
  final String text;

  const ReservationWidget({
    required this.imagePath,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: MediaQuery.of(context).size.width * 0.8,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 13),
                        blurRadius: 25,
                        color: Color(0xFFD27E4A).withOpacity(0.17),
                      ),
                    ],
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
