import 'dart:async';
import 'package:find_hotel/gen/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';

import '../screens/hotel/favoris/favoris.dart';
import '../screens/hotel/home/index.dart';
import '../screens/hotel/reservations/index.dart';


class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  final int? id;
  const BottomBar({Key? key, required this.id}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int? _page;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const IndexScreen(
      status: 0,
    ),
    FavorisScreen(),
    const ReservationIndex(),
    Text('first'),

    //  const AccountScreen(),
    //  const HomeScreen(),
    //  ProfilePage(),
    //  const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  Future<bool> _onBackButtonPrees(BuildContext context) async {
    bool _exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Attention !'),
            content: Text('AppLocalizations.of(context)!.do_you_want_to_exit'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('AppLocalizations.of(context)!.cancel'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('AppLocalizations.of(context)!.exit'))
            ],
          );
        });
    return _exitApp ?? false;
  }

  Timer? timer;
  @override
  void initState() {
    _page = widget.id;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //timer!.cancel();
    setState(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPrees(context),
      child: Scaffold(
        body: pages[_page!],
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 5,
          onTap: updatePage,
          currentIndex: _page!,
          backgroundColor: kwhite,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: kwhite,
              icon: const Icon(Icons.search_rounded),
              label: AppLocalizations.of(context)!.home_page,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Ionicons.heart_outline),
              label: AppLocalizations.of(context)!.favorite_like,
            ),
            BottomNavigationBarItem(
                icon: const Icon(Ionicons.ticket_outline),
                label: AppLocalizations.of(context)!.reservation_now),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.green,
                ),
                label: AppLocalizations.of(context)!.profil_now),
          ],
        ),
      ),
    );
    //   Scaffold(
    //   body: pages[_page],
    //   extendBody: true,
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: _page,
    //     selectedItemColor: GlobalVariables.selectedNavBarColor,
    //     unselectedItemColor: GlobalVariables.unselectedNavBarColor,
    //     backgroundColor: GlobalVariables.backgroundColor,
    //     type: BottomNavigationBarType.fixed,
    //     iconSize: 28,
    //     onTap: updatePage,
    //     items: [
    //       // HOME
    //       BottomNavigationBarItem(
    //         icon: Container(
    //           width: bottomBarWidth,
    //           decoration: BoxDecoration(
    //             border: Border(
    //               top: BorderSide(
    //                 color: _page == 0
    //                     ? GlobalVariables.selectedNavBarColor
    //                     : GlobalVariables.backgroundColor,
    //                 width: bottomBarBorderWidth,
    //               ),
    //             ),
    //           ),
    //           child: const Icon(
    //             Icons.home_outlined,
    //           ),
    //         ),
    //         label: '',
    //       ),
    //       // ACCOUNT
    //       BottomNavigationBarItem(
    //         icon: Container(
    //           width: bottomBarWidth,
    //           decoration: BoxDecoration(
    //             border: Border(
    //               top: BorderSide(
    //                 color: _page == 1
    //                     ? GlobalVariables.selectedNavBarColor
    //                     : GlobalVariables.backgroundColor,
    //                 width: bottomBarBorderWidth,
    //               ),
    //             ),
    //           ),
    //           child: const Icon(
    //             Icons.person_outline_outlined,
    //           ),
    //         ),
    //         label: '',
    //       ),
    //       // CART
    //       BottomNavigationBarItem(
    //         icon: Container(
    //           width: bottomBarWidth,
    //           decoration: BoxDecoration(
    //             border: Border(
    //               top: BorderSide(
    //                 color: _page == 2
    //                     ? GlobalVariables.selectedNavBarColor
    //                     : GlobalVariables.backgroundColor,
    //                 width: bottomBarBorderWidth,
    //               ),
    //             ),
    //           ),
    //           child: Badge(
    //             elevation: 0,
    //             badgeContent: Text(userCartLen.toString()),
    //             badgeColor: Colors.white,
    //             child: const Icon(
    //               Icons.shopping_cart_outlined,
    //             ),
    //           ),
    //         ),
    //         label: '',
    //       ),
    //     ],
    //   ),
    // );
  }
}
