import 'package:find_hotel/onboard/onboard.dart';
import 'package:find_hotel/screens/auth/otp.dart';
import 'package:find_hotel/screens/auth/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/screens/auth/login.dart';

import '../screens/auth/otp_register.dart';
import '../screens/auth/signup.dart';
import '../screens/auth/edit_profile.dart';

import '../screens/hotel/home/search/destination_page.dart';
import '../screens/hotel/home/search/search_result.dart';
import '../utils/bottom_bar.dart';

class NavigationServices {
  NavigationServices(this.context);

  final BuildContext context;

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog),
    );
  }

  void back(Widget widget) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  Future<dynamic> gotoLoginScreen() async {
    return await _pushMaterialPageRoute(LogInScreen());
  }

  Future<dynamic> gotoSplashScreen() async {
    return await _pushMaterialPageRoute(OnBoard());
  }

  Future<dynamic> gotoSignScreen() async {
    return await _pushMaterialPageRoute(SignUpScreen());
  }


  Future<dynamic> gotoEditProfile() async {
    return await _pushMaterialPageRoute(EditProfile());
  }

  Future<dynamic> gotoResetPassword(String email) async {
    return await _pushMaterialPageRoute(ResetPassword(
      email: email,
    ));
  }

  Future<dynamic> gotoOptScreen(String email, String verifcode) async {
    return await _pushMaterialPageRoute(Otp(
      email: email,
      verifCode: verifcode,
    ));
  }

  Future<dynamic> gotoOpt2Screen(String email, String verifcode) async {
    return await _pushMaterialPageRoute(Otp2(
      email: email,
      verifCode: verifcode,
    ));
  }

  Future<dynamic> gotoBottomScreen(int id) async {
    return await _pushMaterialPageRoute(BottomBar(
      id: id
    ));
  }


Future<dynamic> gotosearchResult() async {
    return await _pushMaterialPageRoute(SearchResultScreen());
  }


   Future<dynamic> gototestScreen() async {
    return await _pushMaterialPageRoute(Test());
  }


}
