import 'dart:convert';
import 'dart:io';

import 'package:find_hotel/gen/theme.dart';
import 'package:find_hotel/routes/route_names.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../api/encrypt.dart';
import '../../urls/all_url.dart';
import '../../utils/localfiles.dart';
import '../../widgets/custom_apbar.dart';
import 'package:http/http.dart' as http;

class Otp extends StatefulWidget {
  const Otp({Key? key, required this.email, required this.verifCode})
      : super(key: key);

  final String email;
  final String verifCode;
  @override
  _OtpState createState() => _OtpState(email, verifCode);
}

class _OtpState extends State<Otp> {
  String email = '';
  String verifCode = '';

  _OtpState(
    String email,
    String verifCode,
  ) {
    super.initState();
    this.email = email;
    this.verifCode = verifCode;
  }
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    EasyLoading.dismiss();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    EasyLoading.dismiss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BuildAppbar(AppLocalizations.of(context)!.appbar_forget_message),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    Localfiles.illustration3,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context)!.valid_btn,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.enter_your_otp,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 28),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(4, (index) {
                            return Expanded(
                              child: _textFieldOTP(
                                  controller: _otpControllers[index],
                                  first: index == 0,
                                  last: index == 3),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            String otpCode = '';
                            for (var controller in _otpControllers) {
                              otpCode += controller.text;
                            }
                            print(
                                'OTP Code: $otpCode'); // Affichage du code dans la console
                            if (isCodeValid(otpCode)) {
                              print(email);
                              checkcode(email, otpCode);
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ksecondryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              AppLocalizations.of(context)!.valid_btn,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                GestureDetector(
                  onTap: resendCode(email),
                  child: Text(
                    AppLocalizations.of(context)!.code_pas_recu,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  AppLocalizations.of(context)!.resend_code,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  resendCode(String email) async {
    EasyLoading.show(status: "Loading...");
    var url = Uri.parse(Urls.user);
    // try {

    try {
      final response = await http.post(url, headers: {
        "Accept": "application/json"
      }, body: {
        "email": encrypt(email),
        "action": encrypt("rentali_want_to_resend_code")
      });
      // print(json.decode(response.body));
      var data = jsonDecode(response.body);
      if (kDebugMode) {
        print('dssd');
        print(data);
      }

    } on SocketException {
      if (kDebugMode) {
        print('bbbbbbbbb');
      }
      EasyLoading.showError(
        AppLocalizations.of(context)!.verified_internet,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Try cathc for login to the App ################');
      }
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.showError(
        AppLocalizations.of(context)!.try_again,
      );
    }
  }


  void checkcode(String email, String verificationCode) async {
    EasyLoading.show(status: AppLocalizations.of(context)!.loading);

    var url = Uri.parse(Urls.user);

    try {
      final response = await http.post(url, headers: {
        "Accept": "application/json"
      }, body: {
        "email": encrypt(email),
        "code": encrypt(verificationCode),
        "action": encrypt("rentali_want_to_check_email_user_code_now")
      });
      // print(json.decode(response.body));
      var data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }

      if (response.statusCode == 200) {
        if (data['message'] == "Code is correct") {
          EasyLoading.showSuccess(
              AppLocalizations.of(context)!.success_success);
          NavigationServices(context).gotoResetPassword(email);
        } else {
          EasyLoading.showInfo(AppLocalizations.of(context)!.try_again);
        }
      } else {
        if (data['status'] == 'error') {
          if (data['message'] == 'Incorrect code') {
            EasyLoading.showInfo(AppLocalizations.of(context)!.invalid_code);
          }
          if (data['message'] == "User request to delete account") {
            EasyLoading.showInfo(AppLocalizations.of(context)!.try_again);
          }
          if (data['message'] == 'This email not exist') {
            EasyLoading.showInfo(AppLocalizations.of(context)!.incorrect_email);
          } else {
            EasyLoading.showInfo(AppLocalizations.of(context)!.try_again);
          }
        }
      }
    } on SocketException {
      EasyLoading.showInfo(AppLocalizations.of(context)!.verified_internet);
      if (kDebugMode) {
        print('internet error');
      }
    } catch (e) {
      if (kDebugMode) {
        print('try catch for check code in otp');
      }
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.showInfo(AppLocalizations.of(context)!.try_again);
    }
  }

  bool isCodeValid(String code) {
    // Vérification si le code est vide
    if (code.isEmpty) {
      AppLocalizations.of(context)!.error_all_fields;

      return false;
    }

    // Vérification si le code contient exactement 4 caractères
    if (code.length != 4) {
      AppLocalizations.of(context)!.error_all_fields;

      return false;
    }

    // Vérification si le code ne contient que des chiffres
    for (int i = 0; i < code.length; i++) {
      if (!RegExp(r'^[0-9]$').hasMatch(code[i])) {
        EasyLoading.showError(
          AppLocalizations.of(context)!.invalid_code,
        );
        return false;
      }
    }

    // Si toutes les vérifications sont passées, le code est valide
    return true;
  }

  Widget _textFieldOTP(
      {required TextEditingController controller,
      required bool first,
      required bool last}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
          ),
        ),
      ),
    );
  }
}
