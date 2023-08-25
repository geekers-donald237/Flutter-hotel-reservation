import 'dart:convert';
import 'dart:io';

import 'package:find_hotel/routes/route_names.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:find_hotel/urls/all_url.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../api/encrypt.dart';
import '../../gen/theme.dart';
import '../../utils/localfiles.dart';
import 'package:http/http.dart' as http;

import '../../widgets/custom_apbar.dart';

class Otp2 extends StatefulWidget {
  const Otp2({Key? key, required this.email, required this.verifCode})
      : super(key: key);

  final String email;
  final String verifCode;

  @override
  _Otp2State createState() => _Otp2State(email, verifCode);
}

class _Otp2State extends State<Otp2> {
  String email = '';
  String verifCode = '';
 
  _Otp2State(
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BuildAppbar('Otp'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
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
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.enter_your_otp,
                  style: const TextStyle(
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
                            if (kDebugMode) {
                              print('OTP Code: $otpCode');
                            } // Affichage du code dans la console
                            if (kDebugMode) {
                              print(email);
                            }
                            if (isCodeValid(otpCode)) {
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
                Text(
                  AppLocalizations.of(context)!.code_pas_recu,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
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

  bool isCodeValid(String code) {
    // Vérification si le code est vide
    if (code.isEmpty) {
      EasyLoading.showError(
        AppLocalizations.of(context)!.error_all_fields,
      );
      return false;
    }

    // Vérification si le code contient exactement 4 caractères
    if (code.length != 4) {
      EasyLoading.showError(
        AppLocalizations.of(context)!.error_all_fields,
      );
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

  void checkcode(String email, String verificationCode) async {
    EasyLoading.show(status: AppLocalizations.of(context)!.loading);
    var url = Uri.parse(Urls.user);

    try {
      final response = await http.post(url, headers: {
        "Accept": "application/json"
      }, body: {
        "email": encrypt(email),
        "code": encrypt(verificationCode),
        "action":
            encrypt("rentali_want_to_check_email_user_code_now_for_register")
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
          NavigationServices(context).gotoLoginScreen();
        }
      } else {
        if (data['status'] == 'error') {
          if (data['message'] == 'Incorrect code') {
            EasyLoading.showError(AppLocalizations.of(context)!.invalid_code);
          }
          if (data['message'] == 'This email not exist') {
            EasyLoading.showError(AppLocalizations.of(context)!.verifier_email);
          } else {
            EasyLoading.showError(AppLocalizations.of(context)!.try_again);
          }
        } else {
          EasyLoading.showError(AppLocalizations.of(context)!.try_again);
        }
      }
    } on SocketException {
      if (kDebugMode) {
        print('internet error');
      }
      EasyLoading.showError(AppLocalizations.of(context)!.verified_internet);
    } catch (e) {
      if (kDebugMode) {
        print('try catch dans otp register');
      }
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.showError(AppLocalizations.of(context)!.try_again);
    }
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
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
          ),
        ),
      ),
    );
  }
}
