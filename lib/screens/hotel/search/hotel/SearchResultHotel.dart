import 'dart:io';
import 'dart:convert';
import 'package:find_hotel/gen/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../../../../../api/encrypt.dart';
import '../../../../../models/DestinationModel.dart';
import '../../../../../models/HotelModel.dart';
import '../../../../../models/hotel_model.dart';
import '../../../../../urls/all_url.dart';
import '../../../../../utils/Helpers.dart';
import '../../../../../utils/helper.dart';
import '../../../../../widgets/hotel_card.dart';
import '../../../../../widgets/newsCardSkelton.dart';
import '../../../../../widgets/show_bottom_sheet.dart';
import '../../../../utils/bottom_bar.dart';

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

  _SearchResultHotelState(DestinationModel destination_1) {
    this.destination_1 = destination_1;
    super.initState();
  }

  String state = '0';

  Future<Position> _getGeoLocationPosition() async {


    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  bool isLoading = true;
  List<HotelModels> _hotels = [];

 Future<void> starting() async {
   // if (kDebugMode) {
   //   print('Reggggggggglll####################################');
   // }
   Position position = await _getGeoLocationPosition();
   if(position.latitude.isNaN){

   }else{
     try{
       var url = Uri.parse(Urls.hotel);
       final response = await http.post(url, body: {
         "destination": encrypt(destination_1.destination),
         "accomodation": encrypt(destination_1.accomodation.toString()),
         "longitude": encrypt(position.longitude.toString()),
         "latitude": encrypt(position.latitude.toString()),
         "action": encrypt('get_nearby_hotel'),
       });
       // if (kDebugMode) {
       //   print(response.body);
       // }

       if(response.statusCode == 200){
          var data = jsonDecode(response.body);
          setState(() {
            isLoading = false;
          });
          if (kDebugMode) {
            print(data['data']);
          }
          _hotels.clear();
          for (Map i in data['data']) {
            setState(() {
              isLoading = false;
              _hotels.add(HotelModels.fromJson(i));
            });
          }
       }else{
         setState(() {
           isLoading = false;
         });
       }


     }on SocketException {
       setState(() {
         isLoading = false;
       });
       EasyLoading.showInfo(AppLocalizations.of(context)!.verified_internet,
           duration: const Duration(seconds: 3));
     } catch (e) {
       setState(() {
         isLoading = false;
       });
       if (kDebugMode) {
         print(e.toString());
       }
       EasyLoading.showInfo(AppLocalizations.of(context)!.an_error_occur,
           duration: const Duration(seconds: 3));
     }
   }


  }

  @override
  void initState() {
    // TODO: implement initState
    // if (kDebugMode) {
    //   print('Reggggggggglll####################################');
    // }
    starting();
    super.initState();
  }

  Future<void> _handleRefresh() async {
    // Placez ici votre logique de rafraîchissement, par exemple, une requête à un serveur
    setState(() {
      isLoading = true;
      starting();
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomBar(id: 0,),
          ),
        );
        return false;
      },
      child: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kblue,
            foregroundColor: kblack,
            leading: IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomBar(id: 0,),
                  ),
                );
              },
              icon: const Icon(Icons.backspace),
            ),
          ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligner les éléments aux extrémités
                        children: [
                          _buildItem(
                              AppLocalizations.of(context)!.listes_hotel,
                              Icons.sort,
                              ontap:(){
                                setState(() {
                                  state = '0';
                                });
                              }
                          ),
                          _buildItem(AppLocalizations.of(context)!.item_filtrer,
                                Icons.filter_list,ontap:(){
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SortOptionsBottomSheet();
                                  },
                                );
                                }),

                          _buildItem(AppLocalizations.of(context)!.item_carte, Icons.map,
                              ontap:(){
                            setState(() {
                              state = '2';
                            });
                          }),
                      ],
                    ),
                  ),
                ),
                // Affiche le message "Chargement..." si la liste nearbyHotels est vide
                if (state == '0')
                  isLoading?
                  Expanded(
                     child: ListView.separated(
                      itemCount: 5,
                      itemBuilder: (context, index) => const NewsCardSkelton(),
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: defaultPadding),
                  ),
                   ):
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
                                itemCount: _hotels.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  HotelModels hotel = _hotels[index];
                                  return HotelCard(hotel: hotel, destination_1: destination_1,);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (state == '2') Text("Aucun hôtel trouvé"),
          ]
          ),


        ),
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
