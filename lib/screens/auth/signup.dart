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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;
  bool isObscure = true;

  GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode focusNode = FocusNode();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pswController = TextEditingController();
  final TextEditingController cpswController = TextEditingController();
  String emailc = '', verif_code = '';
  final Uri _url = Uri.parse('https://kitab-oo.com/terms-and-services');
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

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    EasyLoading.dismiss();
    super.initState();
  }

  void _onAdultChanged(bool value) {
    setState(() {
      _isAdult = value;
    });
  }

  bool validateCheckBoxes() {
    return _agreedToTerms && _isAdult;
  }

  back() {
    NavigationServices(context).back(LogInScreen());
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return back();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ksecondryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.register,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                NavigationServices(context).back(LogInScreen());
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: kDefaultPadding,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.already_member + "?",
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
                        AppLocalizations.of(context)!.login_key,
                        style: textButton.copyWith(
                          color: kblue,
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
                    buildInputForm(
                        AppLocalizations.of(context)!.user_name_input,
                        false,
                        usernameController),
                    buildInputForm('Email', false, emailController),
                    // buildInputForm('Phone', false, phoneController),
                    CustomPhoneField(
                      formKey: _formKey,
                      focusNode: focusNode,
                      onPhoneNumberChanged: updatePhoneNumber,
                      phoneNumber: phoneNumber,
                    ),
                    buildInputForm(AppLocalizations.of(context)!.input_pass,
                        true, pswController),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          controller: cpswController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .input_confirm_pass,
                            hintStyle: TextStyle(color: kTextFieldColor),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                icon: isObscure
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: kTextFieldColor,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: kPrimaryColor,
                                      )),
                          ),
                        )),
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
                      "${AppLocalizations.of(context)!.agree_terms_and_condition} 👈",
                      onChanged: _onTermsChanged,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: kDefaultPadding,
                child: CheckBox(
                  AppLocalizations.of(context)!.least_18_years,
                  onChanged: _onAdultChanged,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: kDefaultPadding,
                child: PrimaryButton(
                  buttonText: AppLocalizations.of(context)!.register,
                  ontap: () {
                    if (validateForm(
                        usernameController.text,
                        emailController.text.trim(),
                        phoneNumber,
                        pswController.text,
                        cpswController.text)) {
                      singnIn(
                          usernameController.text,
                          emailController.text.trim(),
                          pswController.text,
                          phoneNumber);
                      // if (kDebugMode) {
                      //   print("success");
                      // }
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: kDefaultPadding,
                  child: Text(
                    AppLocalizations.of(context)!.or_login_with,
                    style: subTitle.copyWith(color: kBlackColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: kDefaultPadding,
                child: LoginOption(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  singnIn(String username, String email, String password,
      String phoneNumber) async {
    EasyLoading.show(status: AppLocalizations.of(context)!.loading);
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
        print('reponse de l\'api');
        print(data);
      }
      var user_data = data['data'];
      if (response.statusCode == 200) {
        if (data['status'] == 'error') {
          if (data['message'] == 'email already exist') {
            print(data['message'] + "status message email");
            EasyLoading.showError(
              duration: Duration(milliseconds: 1500),
              AppLocalizations.of(context)!.email_in_use,
            );
          } else if (data['message'] == 'phone number already exist') {
            print(data['message'] + "status message another");
            EasyLoading.showError(
              duration: Duration(milliseconds: 1500),
              AppLocalizations.of(context)!.phone_number_exist,
            );
          } else {
            EasyLoading.dismiss();
            print(data['message'] + "show error another error");
          }
        } else {
          EasyLoading.dismiss();
          NavigationServices(context)
              .gotoOpt2Screen(email, user_data['code_verif'].toString());
        }
      } else {
        EasyLoading.showError(
            duration: Duration(milliseconds: 1500),
            AppLocalizations.of(context)!.an_error_occur);
        if (kDebugMode) {
          print(data['message'] + "Anotherrrrrr errrroor");
        }
      }
    } on SocketException {
      EasyLoading.showError(
          duration: Duration(milliseconds: 1500),
          AppLocalizations.of(context)!.verified_internet);
      if (kDebugMode) {
        print('internet error');
      }
    } catch (e) {
      print('try catch for register user ######################');
      print(e.toString());
      EasyLoading.dismiss();
    }
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
      EasyLoading.showError(
        duration: Duration(milliseconds: 1500),
        AppLocalizations.of(context)!.error_all_fields,
      );

      return false;
    }

    // Vérification si le mot de passe et la confirmation du mot de passe sont identiques
    if (password != confirmPassword) {
      EasyLoading.showError(
        duration: Duration(milliseconds: 1500),
        AppLocalizations.of(context)!.password_doest_match,
      );

      return false;
    } else if ((password == confirmPassword) && password.length < 6) {
      EasyLoading.showError(
        duration: Duration(milliseconds: 1500),
        AppLocalizations.of(context)!.password_short,
      );

      return false;
    }

    // Vérification si l'email est au bon format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      // showSnackBar(context, 'Invalid Email Address');
      EasyLoading.showError(
        duration: Duration(milliseconds: 1500),
        AppLocalizations.of(context)!.invalid_email,
      );

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
