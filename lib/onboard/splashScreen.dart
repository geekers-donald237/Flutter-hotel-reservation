import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:find_hotel/screens/auth/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/encrypt.dart';
import '../routes/route_names.dart';
import '../urls/all_url.dart';
import '../utils/bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  String? email;
  _loadUserInfo() async {
    //EasyLoading.show(status: "Loading...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String check = prefs.getString('email') ?? 'kitaboo_canot_be_null';
    if (kDebugMode) {
     // print(check);
    }
    if(check == 'kitaboo_canot_be_null') {
      timer?.cancel();
      NavigationServices(context).gotoLoginScreen();
    } else {
      try {
        email = decrypt(prefs.getString('email').toString());
        var url = Uri.parse(Urls.user);
        final response = await http.post(url, headers: {
          "Accept": "application/json"
        }, body: {
          "email": encrypt(email!),
          "action": encrypt("rentali_want_to_check_email_user_splashscreen")
        });
        if (kDebugMode) {
          // print(response.body);
        }
        var data = jsonDecode(response.body);
        if (kDebugMode) {
          // print('dsd');
          // print(data);
        }

        if (response.statusCode == 200) {
          timer?.cancel();
          if (data['status'] == 'error') {
            if (data['message'] == 'User request to delete account') {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LogInScreen()),
                      (route) => false);
            }
            if (data['message'] == 'user is not active') {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LogInScreen()),
                      (route) => false);
            }
            if (data['message'] == 'User not exist') {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LogInScreen()),
                      (route) => false);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LogInScreen()),
                      (route) => false);
            }
          }else{
            var user_detail = data['data'];
            String email = user_detail['email'];
            String user_name = user_detail['user_name'];
            String tel = user_detail['phone_number'];
            String id = user_detail['id'].toString();
            SharedPreferences pref = await SharedPreferences.getInstance();
            await pref.setString('username', encrypt(user_name));
            await pref.setString('email', encrypt(email));
            await pref.setString('phone', encrypt(tel));
            await pref.setString('id', encrypt(id));
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const BottomBar(id: 0, )),
                    (route) => false);
          }
        } else {
          timer?.cancel();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LogInScreen()),
                  (route) => false);

        }
      } on SocketException {
        if (kDebugMode) {
          print('bbbbbbbbb');
        }
        timer?.cancel();
        EasyLoading.showError(
          duration: Duration(milliseconds: 1500),
          AppLocalizations.of(context)!.verified_internet,
        );
      } catch (e) {
        if (kDebugMode) {
          print('Try cathc for splashcreen to the App ################');
        }
        if (kDebugMode) {
          print(e.toString());
        }
        // EasyLoading.showError(duration: Duration(milliseconds: 1500),
        //   AppLocalizations.of(context)!.try_again,
        // );
        timer?.cancel();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LogInScreen()),
                (route) => false);
      }
    }
  }

  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(
        const Duration(seconds: 10), (Timer t) => _loadUserInfo());
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Lottie.asset(
                'assets/lottie/splascreen.json',
                fit: BoxFit.fill,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
