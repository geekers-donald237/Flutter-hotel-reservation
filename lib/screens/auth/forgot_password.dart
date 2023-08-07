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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbar('reset Pwd'),
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
                'Check Your Email Address',
                style: titleText,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Please enter your email address',
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
                buttonText: 'Reset Password',
                ontap: () {
                  EasyLoading.show(status: "Loading.....");
                  if (validateEmail(emailcontroller.text)) {
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
        if (data['status'] == 'error') {
          if (data['message'] == 'User request to delete account') {
            EasyLoading.showError(
              'Le Compte a ete supprime',
            );
          }

          if (data['message'] == 'This email not exist') {
            EasyLoading.showError(
              'Email Already exits',
            );
          }
        } else if (data['status'] == 'success') {
          if (data['message'] == 'Rental for change password') {
            EasyLoading.showSuccess('Success');
            NavigationServices(context).gotoOptScreen(email, '');
          } else {
            EasyLoading.showSuccess('Success');

            NavigationServices(context).gotoOptScreen(email, '');
          }
          // NavigationServices(context).gotoOptScreen(email, verifcode)
        }
      } else {
        EasyLoading.dismiss();
      }
    } on SocketException {
      print('bbbbbbbbb');
    } catch (e) {
      print('tttttttttttt');
      print(e.toString());
    }
  }

  bool validateEmail(String value) {
    if (value.isEmpty) {
      EasyLoading.showError('Please fields All field',
          duration: Duration(seconds: 3));
      return false; // Message d'erreur si l'email est vide
    }

    // Vérification si l'email est au bon format en utilisant une expression régulière
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      EasyLoading.showError('Invalid Email Address',
          duration: Duration(seconds: 3));
      return false; // Message d'erreur si l'email est incorrect
    }

    return true; // Validation réussie, retourne null
  }
}
