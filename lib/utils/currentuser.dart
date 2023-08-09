import 'package:find_hotel/routes/route_names.dart';
import 'package:find_hotel/screens/auth/login.dart';
import 'package:find_hotel/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser extends StatefulWidget {
  const CurrentUser({super.key});

  @override
  State<CurrentUser> createState() => _CurrentUserState();
}

class _CurrentUserState extends State<CurrentUser> {
  int? isLogged;
  @override
  void initState() {
    // TODO: implement initState
    getSharedDataLogin();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  void getSharedDataLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogged = prefs.getInt('isLogged');
    if (isLogged != 0) {

      NavigationServices(context).gotoLoginScreen();
    } else {

      NavigationServices(context).gotohomeScreen();
    }
  }
}
