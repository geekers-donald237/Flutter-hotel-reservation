import 'dart:convert';
import 'dart:io';

import 'package:find_hotel/routes/route_names.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/widgets/primary_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../api/encrypt.dart';
import '../../gen/theme.dart';
import '../../urls/all_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/custom_apbar.dart';
import '../../widgets/formWidget/reset_form.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailcontroller = TextEditingController();

  String email = '', verif_code = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.dismiss();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbar(AppLocalizations.of(context)!.forget_psw),
      body: SingleChildScrollView(
        child: Padding(
          padding: kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
              ),
              Text(
                AppLocalizations.of(context)!.forget_psw,
                style: titleText,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                AppLocalizations.of(context)!.enter_email,
                style: subTitle.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              ResetForm(
                emailController: emailcontroller,
              ),
              SizedBox(
                height: 40,
              ),
              PrimaryButton(
                buttonText: AppLocalizations.of(context)!.reset_psw,
                ontap: () {
                  EasyLoading.show(
                      status: AppLocalizations.of(context)!.loading);
                  if (validateEmail(emailcontroller.text.trim())) {
                    saveCode(emailcontroller.text.trim());
                  } else {
                    print('ddddd');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveCode(String email) async {
    var url = Uri.parse(Urls.user);

    try {
      final response = await http.post(url, headers: {
        "Accept": "application/json"
      }, body: {
        "email": encrypt(email),
        "action": encrypt("rentali_want_to_check_email_user_now")
      });
      // print(json.decode(response.body));
      var data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }
      if (response.statusCode == 200) {
        if (data['status'] == 'success') {
          var user_data = data['data'];
          if (data['message'] == 'Rental for change password') {
            EasyLoading.showSuccess('Success');
            NavigationServices(context)
                .gotoOptScreen(email, user_data['code_verif'].toString());
          } else {
            EasyLoading.showSuccess('Success');
            NavigationServices(context)
                .gotoOptScreen(email, user_data['code_verif'].toString());
          }
        }
      } else {
        if (data['status'] == 'error') {
          if (data['message'] == 'User request to delete account') {
            EasyLoading.showError(
              duration: Duration(milliseconds: 1500),
              AppLocalizations.of(context)!.try_again,
            );
          }
          if (data['message'] == 'This email not exist') {
            EasyLoading.showError(
              duration: Duration(milliseconds: 1500),
              AppLocalizations.of(context)!.email_not_exits,
            );
          }
          if (data['message'] == 'Mail not send') {
            EasyLoading.showError(
              duration: Duration(milliseconds: 1500),
              AppLocalizations.of(context)!.try_again,
            );
          }
        }
      }
    } on SocketException {
      EasyLoading.showError(
          duration: Duration(milliseconds: 1500),
          AppLocalizations.of(context)!.verified_internet);
    } catch (e) {
      print('tttttttttttt');
      print(e.toString());
      EasyLoading.showError(
          duration: Duration(milliseconds: 1500),
          AppLocalizations.of(context)!.try_again);
    }
  
  }

  bool validateEmail(String value) {
    if (value.isEmpty) {
      EasyLoading.showError(
        duration: Duration(milliseconds: 1500),
        AppLocalizations.of(context)!.error_all_fields,
      );
      return false; // Message d'erreur si l'email est vide
    }

    // Vérification si l'email est au bon format en utilisant une expression régulière
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      EasyLoading.showError(
        duration: Duration(milliseconds: 1500),
        AppLocalizations.of(context)!.invalid_email,
      );
      return false; // Message d'erreur si l'email est incorrect
    }

    return true; // Validation réussie, retourne null
  }
}
