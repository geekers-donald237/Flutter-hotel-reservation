import 'package:find_hotel/screens/home/rent_car/rent_card.dart';
import 'package:find_hotel/screens/home/stay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';

import '../../gen/theme.dart';
import '../../routes/route_names.dart';
import '../../widgets/custom_icon_button.dart';
import 'package:find_hotel/urls/all_url.dart';

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

  String idadmin2 = '';

  List<Widget> mytabs = [];
  List<Widget> tabs1 = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    mytabs = [
      const StayScreen(),
      const RentCarScreen(),
      Text('2'),
      Text('3'),
    ];

    _tabController = TabController(length: mytabs.length, vsync: this);
    _tabController.index =
        status; // Set the initial index after initializing the TabController
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

  Widget headerWidget() {
    const name = "John";
    const surname = "Doe";
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(Urls.userAvatar + name + "+" + surname),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(name, style: TextStyle(fontSize: 14, color: kDarkGreyColor)),
            SizedBox(
              height: 10,
            ),
            Text('$name$surname@gmail.com',
                style: TextStyle(fontSize: 14, color: kDarkGreyColor))
          ],
        )
      ],
    );
  }

  Drawer CustomDrawer() {
    return Drawer(
      child: Material(
        color: Colors.white,
        textStyle: TextStyle(color: kblack),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                headerWidget(),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: AppLocalizations.of(context)!.drawer_person,
                    icon: Ionicons.person,
                    onPressed: () {
                      NavigationServices(context).gotoEditProfile();
                    }),
                const SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: AppLocalizations.of(context)!.drawer_account,
                    icon: Icons.account_box_rounded,
                    onPressed: () {}),
                const SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: AppLocalizations.of(context)!.drawer_bug_report,
                    icon: Ionicons.bug_outline,
                    onPressed: () {}),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: AppLocalizations.of(context)!.drawer_propos,
                    icon: Icons.info_outline,
                    onPressed: () {}),
                const SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: AppLocalizations.of(context)!.drawer_logout,
                    icon: Icons.logout,
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
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
          length: 4,
          child: Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 80,
              // shape: Border(bottom: BorderSide(color: kblack, width: 2)),
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
                children: [
                  const Text(
                    "Rental",
                    style: TextStyle(color: kwhite),
                  ),
                  Text(
                    "Find The Best Deal for Your holidays",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              actions: const [
                CustomIconButton(
                  icon: Icon(
                    Ionicons.search_outline,
                    color: kwhite,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 12),
                  child: CustomIconButton(
                    icon: Badge(
                        backgroundColor: accent,
                        child: Icon(
                          Ionicons.notifications_outline,
                          color: kwhite,
                        )),
                  ),
                ),
              ],
              bottom: TabBar(
                padding: EdgeInsets.only(bottom: 6),
                controller:
                _tabController, // Connect the TabBar to the TabController
                indicatorColor: Colors.white,
                indicatorWeight: 6,
                isScrollable: true,
                physics: ClampingScrollPhysics(),
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
                        SizedBox(width: 15),
                        Icon(
                          Ionicons.home_outline,
                        ),
                        SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.your_stay,
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Icon(
                          Ionicons.car_sport_sharp,
                        ),
                        SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.rent_car,
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Icon(
                          Ionicons.airplane_sharp,
                        ),
                        SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.fly_now,
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Icon(
                          Ionicons.car_outline,
                        ),
                        SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.taxi_now,
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
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
                  mytabs[2],
                  mytabs[3],
                ],
              ),
            ),
          )),
    );
  }
}
