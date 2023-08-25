import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api/google_signing_api.dart';

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

String getAssetName(String fileName, String type) {
  return "assets/images/$type/$fileName";
}

TextTheme getTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(text)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}

void message(BuildContext context, String text1, String text, Color col,
    String bubble, String rond, String closegood) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Stack(
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              height: 90,
              decoration: BoxDecoration(
                  color: col,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  const SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text1,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        const Spacer(),
                        Text(
                          text,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(20)),
              child: SvgPicture.asset(
                bubble,
                height: 48,
                width: 40,
                color: Colors.redAccent,
              ),
            ),
          ),
          Positioned(
              top: -20,
              left: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    rond,
                    height: 40,
                  ),
                  Positioned(
                    top: 10,
                    child: SvgPicture.asset(
                      closegood,
                      height: 16,
                    ),
                  )
                ],
              ))
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}

Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.remove('id_type');
  await pref.remove('email');
  await pref.remove('address');
  await pref.remove('phone');
  await pref.remove('username');
  return await pref.remove('token');
}

bool isDarkMode(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.light) {
    return false;
  } else {
    return true;
  }
}

String? validateEmail(String? value, BuildContext context) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value ?? ''))
    return AppLocalizations.of(context)!.incorrect_email;
  else
    return null;
}

String? validateConfirmPassword(
    String? password, String? confirmPassword, BuildContext context) {
  if (password != confirmPassword) {
    return AppLocalizations.of(context)!.password_doest_match;
  } else if (confirmPassword?.length == 0) {
    return 'required';
  } else {
    return null;
  }
}

String? validatePassword(String? value, BuildContext context) {
  if ((value?.length ?? 0) < 6) {
    return 'must be 6 caracter';
  } else {
    return null;
  }
}

showAlertDialog(
    BuildContext context, String title, String content, bool addOkButton) {
  // set up the AlertDialog
  Widget? okButton;
  if (addOkButton) {
    okButton = TextButton(
      child: Text('ok'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
  if (Platform.isIOS) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [if (okButton != null) okButton],
    );
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  } else {
    AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [if (okButton != null) okButton]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

String? validateMobile(String? value, BuildContext context) {
  String pattern = r'(^\+?[0-9]*$)';
  RegExp regExp = RegExp(pattern);
  if (value?.length == 0) {
    return 'required';
  } else if (!regExp.hasMatch(value ?? '')) {
    return 'phone number';
  } else if (value!.length < 9) {
    return "must be > 9";
  }
  return null;
}

String? validateName(String? value, BuildContext context) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(pattern);
  if (value?.length == 0) {
    return 'required';
  } else if (!regExp.hasMatch(value ?? '')) {
    return 'required';
  }
  return null;
}

Widget? Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();
Widget placeholderWidget() =>
    Image.asset('assets/images/grey.jpg', fit: BoxFit.cover);

onMessageDialog(
    String title, String button, BuildContext context, Widget onPressed) {
  final action = CupertinoActionSheet(
    message: Text(
      title,
      style: const TextStyle(fontSize: 15.0),
    ),
    actions: <Widget>[
      CupertinoActionSheetAction(
        isDefaultAction: false,
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Image(
          image: AssetImage('assets/images/success.gif'),
          height: 150.0,
        ),
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text(button),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => onPressed),
            (route) => false);
      },
    ),
  );
  showCupertinoModalPopup(context: context, builder: (context) => action);
}

Future signIn() async {
  await GoogleSignInApi.login();
}
