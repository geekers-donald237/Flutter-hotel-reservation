import 'package:find_hotel/screens/home/stay.dart';
import 'package:flutter/material.dart';
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
      Text('aussi'),
      Text('aussi'),
      Text('aussi'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kblue,
        toolbarHeight: 80, // Ajustez la hauteur de l'AppBar

        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Rental",
              style: TextStyle(color: kwhite),
            ),
            Text(
              AppLocalizations.of(context)!.the_best_deal_for_your_holidays,
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
      ),
      drawer: CustomDrawer(),
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Material(
                child: Container(
                  color: kblue,
                  height: 60,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: TabBar(
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
                ),
              ),
              Expanded(
                  child: TabBarView(children: [
                StayScreen(),
                Center(
                  child: Text('ddddd'),
                ),
                Center(
                  child: Text('ddddd'),
                ),
              ]))
            ],
          )),
    );
  }
}
