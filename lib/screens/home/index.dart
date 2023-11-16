
import 'package:find_hotel/screens/home/rent_car/rent_car.dart';
import 'package:find_hotel/screens/hotel/home/stay.dart';
import 'package:find_hotel/utils/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';

import 'package:find_hotel/urls/all_url.dart';

import '../../gen/theme.dart';
import '../../routes/route_names.dart';
import '../../utils/drawer_item.dart';
import '../../utils/nav_drawer.dart';
import '../../widgets/custom_icon_button.dart';
import '../car/showroom.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({
    Key? key,
    required this.status,
  }) : super(key: key);
  final int status;
  @override
  State<IndexScreen> createState() => _IndexScreenState(status);
}

class _IndexScreenState extends State<IndexScreen>
    with SingleTickerProviderStateMixin {
  int status = 0;
  _IndexScreenState(int status) {
    super.initState();
    this.status = status;
  }

  String idadmin1 = '';
  String idadmin2 = '';
  String email1 = '';
  String email2 = '';
  String userName1 = '';
  String userName2 = '';

  Future<void> gett() async {
    idadmin2 = await getUserId();
    email2 = await getEmail();
    userName2 = await getUserName();
    setState(() {
      idadmin1 = idadmin2;
      email1 = email2;
      userName1 = userName2;
    });
  }

  List<Widget> mytabs = [];
  List<Widget> tabs1 = [];
  late TabController _tabController;

  @override
  void initState() {
    gett();
    super.initState();
    mytabs = [
      const StayScreen(),
      const RentCarScreen(),
      // const RentCarScreen(),
      // Text('aussi'),
      // Text('aussi'),
    ];

    _tabController = TabController(length: mytabs.length, vsync: this);
    _tabController.index =
        status; // Set the initial index after initializing the TabController

    EasyLoading.dismiss();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //int _tabIndex = status;

  void onPressed(int tabIndex) {
    setState(() {
      status = tabIndex;
    });
  }
  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // L'utilisateur ne peut pas annuler en cliquant à l'extérieur
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            // Supprimer les bords
            borderRadius: BorderRadius.circular(0),
          ),
          title: Text(AppLocalizations.of(context)!.exit_title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.exit_text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.exit_response_non),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.exit_response_oui),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showExitConfirmationDialog(context);
        return false;
      },
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            drawer: NavDrawer(),
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 80,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          ksecondryColor,
                          ksecondryColor,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp)),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Kitab-oo.com",
                    style: TextStyle(color: kwhite),
                  ),
                  // Text(
                  //   AppLocalizations.of(context)!.find_the_best_deal_in_this_place,
                  //   style: Theme.of(context).textTheme.labelMedium,
                  // ),
                ],
              ),
              actions: const [
                // Padding(
                //   padding: EdgeInsets.only(left: 8.0, right: 12),
                //   child: CustomIconButton(
                //     icon: Badge(
                //         backgroundColor: accent,
                //         child: Icon(
                //           Ionicons.notifications_outline,
                //           color: kwhite,
                //         )),
                //   ),
                // ),
              ],
              bottom: TabBar(
                padding: const EdgeInsets.only(bottom: 6),
                controller:
                _tabController, // Connect the TabBar to the TabController
                indicatorColor: Colors.white,
                indicatorWeight: 6,
                isScrollable: true,
                physics: const ClampingScrollPhysics(),
                unselectedLabelColor: kwhite,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: kwhite, width: 2),
                ),
                tabs: [
                  Tab(
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        const Icon(
                          Ionicons.home_outline,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.your_stay,
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        const Icon(
                          Ionicons.car_sport_sharp,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.rent_car,
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                  // Tab(
                  //   child: Row(
                  //     children: const [
                  //       SizedBox(width: 15),
                  //       Icon(
                  //         Icons.wash_outlined,
                  //       ),
                  //       SizedBox(width: 10),
                  //       Text(
                  //         'pressing',
                  //       ),
                  //       SizedBox(width: 15),
                  //     ],
                  //   ),
                  // ),
                  // Tab(
                  //   child: Row(
                  //     children: [
                  //       const SizedBox(width: 15),
                  //       const Icon(
                  //         Ionicons.airplane_sharp,
                  //       ),
                  //       const SizedBox(width: 10),
                  //       Text(
                  //         AppLocalizations.of(context)!.fly_now,
                  //       ),
                  //       const SizedBox(width: 15),
                  //     ],
                  //   ),
                  // ),
                  // Tab(
                  //   child: Row(
                  //     children: [
                  //       const SizedBox(width: 15),
                  //       const Icon(
                  //         Ionicons.car_outline,
                  //       ),
                  //       const SizedBox(width: 10),
                  //       Text(
                  //         AppLocalizations.of(context)!.taxi_now,
                  //       ),
                  //       const SizedBox(width: 15),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.blueGrey,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp)),
              child: TabBarView(
                controller:
                _tabController, // Connect the TabBarView to the TabController
                children: [
                  mytabs[0],
                  mytabs[1],
                  // mytabs[2],
                  // mytabs[3],
                  // mytabs[4],
                ],
              ),
            ),
          )),
    );
  }
}
