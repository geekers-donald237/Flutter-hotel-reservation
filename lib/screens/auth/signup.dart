import 'dart:convert';
import 'dart:io';

import 'package:find_hotel/routes/route_names.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/widgets/checkbox.dart';
import 'package:find_hotel/widgets/primary_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../api/encrypt.dart';
import '../../gen/theme.dart';

import '../../urls/all_url.dart';
import '../../widgets/custom_apbar.dart';
import '../../widgets/formWidget/custom_phone_field.dart';
import '../../widgets/formWidget/login_option.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;
  GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode focusNode = FocusNode();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pswController = TextEditingController();
  final TextEditingController cpswController = TextEditingController();
  String emailc = '', verif_code = '';
  final Uri _url = Uri.parse('https://flutter.dev');
  bool checkedAgreeTerms = false;
  bool check18YearsOld = false;

  String phoneNumber =
      ""; // Variable pour stocker le numéro de téléphone dans ce widget

  void updatePhoneNumber(String newPhoneNumber) {
    // Fonction de rappel pour mettre à jour le numéro de téléphone dans ce widget
    phoneNumber = newPhoneNumber;
    print('Updated Phone Number: $phoneNumber');
  }

  bool _agreedToTerms = false;
  bool _isAdult = false;

  void _onTermsChanged(bool value) {
    setState(() {
      _agreedToTerms = value;
    });
  }

  void _onAdultChanged(bool value) {
    setState(() {
      _isAdult = value;
    });
  }

  bool validateCheckBoxes() {
    return _agreedToTerms && _isAdult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbar("Register"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Text(
                'Create Account',
                style: titleText,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Row(
                children: [
                  Text(
                    'Already a member?',
                    style: subTitle,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()));
                    },
                    child: Text(
                      'Log In',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Column(
                children: [
                  buildInputForm('User Name', false, usernameController),
                  buildInputForm('Email', false, emailController),
                  // buildInputForm('Phone', false, phoneController),
                  CustomPhoneField(
                    formKey: _formKey,
                    focusNode: focusNode,
                    onPhoneNumberChanged: updatePhoneNumber,
                    phoneNumber: phoneNumber,
                  ),
                  buildInputForm('Password', true, pswController),
                  buildInputForm('Confirm Password', true, cpswController),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: GestureDetector(
                  onTap: () {
                    _launchUrl();
                  },
                  child: CheckBox(
                    'Agree to terms and conditions.  👈',
                    onChanged: _onTermsChanged,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: CheckBox(
                'I have at least 18 years old.',
                onChanged: _onAdultChanged,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: PrimaryButton(
                buttonText: 'Sign Up',
                ontap: () {
                  if (validateForm(
                      usernameController.text,
                      emailController.text,
                      phoneNumber,
                      pswController.text,
                      cpswController.text)) {
                    EasyLoading.show(status: "Loading...");
                    singnIn(usernameController.text, emailController.text,
                        pswController.text, phoneNumber);
                    if (kDebugMode) {
                      print("sucess");
                    }
                    clearController();
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: Text(
                'Or log in with:',
                style: subTitle.copyWith(color: kBlackColor),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: LoginOption(),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  singnIn(String username, String email, String password,
      String phoneNumber) async {
    EasyLoading.show(status: 'Loading');
    var url = Uri.parse(Urls.user);
    // try {

    try {
      final response = await http.post(url, headers: {
        "Accept": "application/json"
      }, body: {
        "user_name": encrypt(username),
        "phone_number": encrypt(phoneNumber),
        "email": encrypt(email),
        "password": encrypt(password),
        "action": encrypt("rentali_want_to_register_now")
      });
      var data = jsonDecode(response.body);
      if (kDebugMode) {
        print('dssd');
        print(data);
      }
      if (response.statusCode == 200) {
        if (data['status'] == 'error') {
          if (data['message'] == 'email already exist') {
            print(data['message'] + "ststus message email");
            EasyLoading.showError(
              'Email already in use',
            );
          } else if (data['message'] == 'phone number already exist') {
            print(data['message'] + "ststus message another");
            EasyLoading.showError(
              'Phone Numnber Already exits',
            );
          } else {
            EasyLoading.dismiss();
            print(data['message'] + "show error another error");
          }
        } else {
          EasyLoading.dismiss();
          NavigationServices(context).gotoOpt2Screen(emailc, verif_code);
        }
      } else {
        EasyLoading.showError('An Error Occur');
        print(data['message'] + "Anotherrrrrr errrroor");

        EasyLoading.dismiss();
      }
    } on SocketException {
      EasyLoading.dismiss();

      print('bbbbbbbbb');
    } catch (e) {
      print('tttttttttttt');

      print(e.toString());
      EasyLoading.dismiss();
    }
    // if (response.statusCode == 200) {
    // print(response.body);

    //   if (data["message"] == 'Success Connexion') {
    //     String id_admin = data['id_admin'].toString();
    //     String email = data['email'];
    //     String user_name = data['user_name'];
    //     String tel = data['phone'];

    //     SharedPreferences pref = await SharedPreferences.getInstance();
    //     await pref.setString('id', encrypt(id_admin));
    //     // await pref.setString('id_entreprise', id_entreprise);
    //     await pref.setString('username', encrypt(user_name));
    //     await pref.setString('email', encrypt(email));
    //     await pref.setString('phone', encrypt(tel));
    //     EasyLoading.dismiss();
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context) => Start()),
    //         (route) => false);
    //   }
    //   if (data["message"] == 'no able') {
    //     EasyLoading.showError('Login incorrect',
    //         duration: Duration(seconds: 5));
    //   }
    //   if (data["message"] == 'login ou mot de passe incorrect! ') {
    //     EasyLoading.showError('Login incorrect',
    //         duration: Duration(seconds: 5));
    //   }
    //   if (data["message"] == 'verified_your_account') {
    //     EasyLoading.showError('verify your email address please',
    //         duration: Duration(seconds: 5));
    //   }
    // } else {
    //   EasyLoading.showError('verify internet');
    // }
    // }
    //  on SocketException catch (e) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text('verify internet')));
    // } catch (e) {
    //   print(e);
    //   EasyLoading.showError('an error occur');
    // }
    // }
  }

  void clearController() {
    usernameController.clear();
    emailController.clear();
    pswController.clear();
    cpswController.clear();
    phoneController.clear();
  }

  bool validateForm(String name, String email, String phoneNumber,
      String password, String confirmPassword) {
    // Vérification si aucun champ n'est vide
    if (name.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        !validateCheckBoxes()) {
      EasyLoading.showError('Please fields All field',
          duration: Duration(seconds: 3));

      return false;
    }

    // Vérification si le mot de passe et la confirmation du mot de passe sont identiques
    if (password != confirmPassword) {
      EasyLoading.showError('Password doesnt macth',
          duration: Duration(seconds: 3));

      return false;
    } else if ((password == confirmPassword) && password.length < 6) {
      EasyLoading.showError('Password is too short',
          duration: Duration(seconds: 3));

      return false;
    }

    // Vérification si l'email est au bon format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      // showSnackBar(context, 'Invalid Email Address');
      EasyLoading.showError('Invalid Email Address',
          duration: Duration(seconds: 3));

      return false;
    }
    EasyLoading.dismiss();

    // Si toutes les validations sont réussies, retourne true pour indiquer que le formulaire est valide
    return true;
  }

  Future<void> _launchUrl() async {
    if (await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  loader(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Padding buildInputForm(
      String hint, bool pass, TextEditingController textEditingController) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: textEditingController,
          obscureText: pass ? _isObscure : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: kTextFieldColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
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
                          ))
                : null,
          ),
        ));
  }
}
