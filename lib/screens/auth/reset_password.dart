import 'dart:convert';
import 'dart:io';

import 'package:find_hotel/routes/route_names.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../api/encrypt.dart';
import '../../gen/theme.dart';
import '../../urls/all_url.dart';
import '../../widgets/custom_apbar.dart';
import '../../widgets/primary_button.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});

  final String email;
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isObscure = true;
  final TextEditingController pswController = TextEditingController();
  final TextEditingController cpswController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbar('Reset Pwd'),
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
              ),
              Text(
                'Reset Your Pwd',
                style: titleText,
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  buildInputForm('Password', true, pswController),
                  buildInputForm('Confirm Password', true, cpswController),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                buttonText: 'Reset',
                ontap: () {
                  EasyLoading.show(status: 'Loading');
                  if (validateLoginForm(
                      pswController.text, cpswController.text)) {
                    resetPassword(pswController.text, widget.email);
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearController() {
    cpswController.clear();
    pswController.clear();
  }

// Utilisation de la fonction de validation dans un exemple de formulaire de connexion (login)

  Padding buildInputForm(
      String label, bool pass, TextEditingController textEditingController) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: textEditingController,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
      ),
    );
  }

  bool validateLoginForm(String password, String cpassword) {
    // Vérification si aucun champ n'est vide
    if (cpassword.isEmpty || password.isEmpty) {
      EasyLoading.showError('Please fields All field',
          duration: Duration(seconds: 3));
      return false;
    }

    if (cpassword != password) {
      EasyLoading.showError('Password doesn\'t macth',
          duration: Duration(seconds: 3));
      return false;
    } else {
      if (password.length < 6) {
        EasyLoading.showError('Password is Too Short',
            duration: Duration(seconds: 3));
      }
    }

    // Si toutes les validations sont réussies, retourne true pour indiquer que le formulaire est valide
    return true;
  }

  void resetPassword(String password, String email) async {
    var url = Uri.parse(Urls.user);

    try {
      final response = await http.post(url, headers: {
        "Accept": "application/json"
      }, body: {
        "password": encrypt(password),
        "email": encrypt(email),
        "action": encrypt("rentali_want_to_change_password_now")
      });
      // print(json.decode(response.body));
      var data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }
      if (response.statusCode == 400) {
        if (data['message'] == 'This email not exist') {
          EasyLoading.showError("Invalid Email Address");
        } else if (data['message'] == 'User request to delete account') {
          EasyLoading.showError('Compte Supprime');
        } else {
          EasyLoading.showError('Mail Not Send');
        }
      } else {
        EasyLoading.showSuccess("Password reset Succefuly");
        NavigationServices(context).gotoLoginScreen();
      }
    } on SocketException {
      print('bbbbbbbbb');
      EasyLoading.dismiss();
    } catch (e) {
      print('tttttttttttt');
      print(e.toString());
      EasyLoading.dismiss();
    }
  }
}
