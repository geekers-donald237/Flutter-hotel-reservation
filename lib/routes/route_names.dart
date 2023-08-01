import 'package:find_hotel/screens/auth/otp.dart';
import 'package:find_hotel/screens/auth/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/routes/routes.dart';
import 'package:find_hotel/screens/auth/login.dart';
import 'package:find_hotel/screens/profile/profile_screen.dart';

import '../screens/auth/signup.dart';
import '../screens/profile/country_screen.dart';
import '../screens/profile/currency_screen.dart';
import '../screens/profile/edit_profile.dart';
import '../screens/profile/hepl_center_screen.dart';
import '../screens/profile/how_do_screen.dart';
import '../screens/profile/invite_screen.dart';
import '../screens/profile/settings_screen.dart';

class NavigationServices {
  NavigationServices(this.context);

  final BuildContext context;

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog: false}) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog),
    );
  }

  void gotoSplashScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.Splash, (Route<dynamic> route) => false);
  }

  void gotoIntroductionScreen() {
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.IntroductionScreen,
        (Route<dynamic> route) => false);
  }

  Future<dynamic> gotoLoginScreen() async {
    return await _pushMaterialPageRoute(LogInScreen());
  }

  // Future<dynamic> gotoTabScreen() async {
  //   return await _pushMaterialPageRoute(BottomTabScreen());
  // }

  Future<dynamic> gotoSignScreen() async {
    return await _pushMaterialPageRoute(SignUpScreen());
  }

  // Future<dynamic> gotoForgotPassword() async {
  //   return await _pushMaterialPageRoute(ForgotPasswordScreen());
  // }

  // Future<dynamic> gotoSearchScreen() async {
  //   return await _pushMaterialPageRoute(SearchScreen());
  // }

  // Future<dynamic> gotoHotelHomeScreen() async {
  //   return await _pushMaterialPageRoute(HotelHomeScreen());
  // }

  // Future<dynamic> gotoFiltersScreen() async {
  //   return await _pushMaterialPageRoute(FiltersScreen());
  // }

  // Future<dynamic> gotoRoomBookingScreen(String hotelname) async {
  //   return await _pushMaterialPageRoute(
  //       RoomBookingScreen(hotelName: hotelname));
  // }

  // Future<dynamic> gotoHotelDetailes(HotelListData hotelData) async {
  //   return await _pushMaterialPageRoute(HotelDetailes(
  //     hotelData: hotelData,
  //   ));
  // }

  // Future<dynamic> gotoReviewsListScreen() async {
  //   return await _pushMaterialPageRoute(ReviewsListScreen());
  // }

  Future<dynamic> gotoEditProfile() async {
    return await _pushMaterialPageRoute(EditProfile());
  }

  Future<dynamic> gotoSettingsScreen() async {
    return await _pushMaterialPageRoute(SettingsScreen());
  }

  Future<dynamic> gotoHeplCenterScreen() async {
    return await _pushMaterialPageRoute(HeplCenterScreen());
  }

  Future<dynamic> gotoResetPassword() async {
    return await _pushMaterialPageRoute(ResetPassword());
  }

  Future<dynamic> gotoInviteFriend() async {
    return await _pushMaterialPageRoute(InviteFriend());
  }

  Future<dynamic> gotoCurrencyScreen() async {
    return await _pushMaterialPageRoute(CurrencyScreen(),
        fullscreenDialog: true);
  }

  Future<dynamic> gotoCountryScreen() async {
    return await _pushMaterialPageRoute(CountryScreen(),
        fullscreenDialog: true);
  }

  Future<dynamic> gotoHowDoScreen() async {
    return await _pushMaterialPageRoute(HowDoScreen());
  }

  Future<dynamic> gotoProfileScreen() async {
    return await _pushMaterialPageRoute(ProfileScreen());
  }


}
