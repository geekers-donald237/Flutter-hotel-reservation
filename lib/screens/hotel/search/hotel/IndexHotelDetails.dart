import 'package:find_hotel/gen/theme.dart';
import 'package:find_hotel/screens/hotel/search/room/roomListResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../models/DestinationModel.dart';
import '../../../../models/HotelModel.dart';
import 'SearchResultHotel.dart';
import 'appartListResult.dart';
import 'hotelDetailScreen.dart';

class IndexHotelDetails extends StatefulWidget {
  const IndexHotelDetails({
    super.key,
    required this.hotel,
    required this.destination_1
  });

  final HotelModels hotel;
  final DestinationModel destination_1;

  @override
  State<IndexHotelDetails> createState() => _IndexHotelDetailsState();
}

class _IndexHotelDetailsState extends State<IndexHotelDetails> {
// Vous pouvez maintenant utiliser 'emptyTravel' comme une instance vide de TravelDestination.
  _IndexHotelDetailsState() {
    super.initState();
  }
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SearchResultHotel(destination_1: widget.destination_1,)),
                (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kblue,
          foregroundColor: kblack,
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
                size: 30,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 12),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.share_social_outline, size: 30),
                )),
          ],
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Material(
                child: Container(
                  color: Colors.white,
                  height: 60,
                  child: TabBar(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    unselectedLabelColor: kgrey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 237, 241, 243),
                      border: Border.all(color: kblue, width: 1),
                    ),
                    tabs: [
                      Tab(
                        child: SizedBox(
                          height: 55,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.hotel_reservation,
                              style: const TextStyle(color: kblack),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          height: 55,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.rooms_,
                              style: const TextStyle(color: kblack),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          height: 55,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.apartment_,
                              style: const TextStyle(color: kblack),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                    children: [
                      HotelDetailScreen(hotel: widget.hotel, destination_1: widget.destination_1,),
                      RoomListResult(hotel: widget.hotel,destination_1: widget.destination_1,),
                      appartListResult(hotel: widget.hotel)
                    ]
                ),
              ),
            ],
          ),
        ),
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
                const SizedBox(
                  height: 35,
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 13),
                        blurRadius: 25,
                        color: const Color(0xFFD27E4A).withOpacity(0.17),
                      ),
                    ],
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(
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
