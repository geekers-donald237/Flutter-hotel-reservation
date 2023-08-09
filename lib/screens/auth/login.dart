import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/screens/auth/forgot_password.dart';
import 'package:find_hotel/screens/auth/signup.dart';

import 'package:find_hotel/widgets/primary_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/encrypt.dart';
import '../../gen/theme.dart';
import '../../routes/route_names.dart';
import '../../urls/all_url.dart';
import '../../widgets/custom_apbar.dart';
import '../../widgets/formWidget/login_option.dart';
import 'package:http/http.dart' as http;

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pswController = TextEditingController();
  String emailc = '', verif_code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kblue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text("Login"),
        centerTitle: true,
          automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.info)),
        ],
      ),
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                'Welcome Back',
                style: titleText,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'New to this app?',
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                              (route) => false);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  buildInputForm('Email', false, emailController),
                  buildInputForm('Password', true, pswController),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen()));
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: kZambeziColor,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                buttonText: 'Log In',
                ontap: () {
                  if (validateLoginForm(
                      emailController.text, pswController.text)) {
                    login(emailController.text, pswController.text);
                    // clearController();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Or log in with:',
                  style: subTitle.copyWith(color: kBlackColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              LoginOption(),
            ],
          ),
        ),
      ),
    );
  }

  void clearController() {
    emailController.clear();
    pswController.clear();
  }

// Fonction de validation du formulaire de connexion (login)
  bool validateLoginForm(String email, String password) {
    // Vérification si aucun champ n'est vide
    if (email.isEmpty || password.isEmpty) {
      EasyLoading.showError('Please fields All field',
          duration: Duration(seconds: 3));
      return false;
    }

    // Vérification si l'email est au bon format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      EasyLoading.showError('Invalid Email Address',
          duration: Duration(seconds: 3));
      return false;
    }

    // Si toutes les validations sont réussies, retourne true pour indiquer que le formulaire est valide
    return true;
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

  storeLoginInfo() async {
    print("Shared pref called");
    int isLogged = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isLogged', isLogged);
    print(prefs.getInt('isLogged'));
  }

  login(String email, String password) async {
    EasyLoading.show(status: "Loading...");
    var url = Uri.parse(Urls.user);
    // try {

    try {
      final response = await http.post(url, headers: {
        "Accept": "application/json"
      }, body: {
        "email": encrypt(email),
        "password": encrypt(password),
        "action": encrypt("rentali_want_to_login_user_now")
      });
      // print(json.decode(response.body));
      var data = jsonDecode(response.body);
      if (kDebugMode) {
        print('dssd');
        print(data);
      }

      if (response.statusCode == 200) {
        if (data['status'] == 'error') {
          if (data['message'] == 'Verify your email') {
            print(data['message'] + "ststus message email");
            EasyLoading.showError(
              'Verify your email',
            );
            NavigationServices(context).gotoOptScreen(email, verif_code);
          } else if (data['message'] == 'Incorrect password') {
            print(data['message'] + "ststus message another");
            EasyLoading.showError(
              'Incorrect password',
            );
          } else if (data['message'] == 'This email not exist') {
            EasyLoading.showError(
              'Incorrect email',
            );
          } else {
            EasyLoading.dismiss();
            print(data['message'] + "show error another error");
          }
        } else {
          EasyLoading.dismiss();
          storeLoginInfo();

          NavigationServices(context).gotohomeScreen();
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
}
