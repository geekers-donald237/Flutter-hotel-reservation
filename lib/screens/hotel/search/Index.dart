import 'package:find_hotel/gen/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../models/DestinationModel.dart';
import '../../../../utils/bottom_bar.dart';
import 'hotel/SearchResultHotel.dart';

class SearchIndex extends StatefulWidget {
  const SearchIndex({
    super.key,
    required this.destination_1
  });

  final DestinationModel destination_1;

  @override
  State<SearchIndex> createState() => _SearchIndexState(destination_1);
}

class _SearchIndexState extends State<SearchIndex> {
  DestinationModel destination_1 = DestinationModel(
    destination: '',
    accomodation: 0,
    dateTravel: '',
    adults: 0,
    children: 0,
  );

// Vous pouvez maintenant utiliser 'emptyTravel' comme une instance vide de TravelDestination.

  _SearchIndexState(this.destination_1) {
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const BottomBar(id: 0, )),
                (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kgrey,
          elevation: 1,
          title: Text(AppLocalizations.of(context)!.my_reservation),
        ),
        body: DefaultTabController(
            length: 2,
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
                          child: Container(
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
                          child: Container(
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
                          SearchResultHotel(destination_1: destination_1,),
                          Text(''),
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
