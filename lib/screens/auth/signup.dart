import 'package:flutter/material.dart';
import 'package:find_hotel/widgets/checkbox.dart';
import 'package:find_hotel/widgets/primary_button.dart';

import '../../gen/theme.dart';

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

  String phoneNumber =
      ""; // Variable pour stocker le numéro de téléphone dans ce widget

  void updatePhoneNumber(String newPhoneNumber) {
    // Fonction de rappel pour mettre à jour le numéro de téléphone dans ce widget
    phoneNumber = newPhoneNumber;
    print('Updated Phone Number: $phoneNumber');
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
                  buildInputForm('UserName', false, usernameController),
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
              child: CheckBox('Agree to terms and conditions.'),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: kDefaultPadding,
              child: CheckBox('I have at least 18 years old.'),
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
                    print("sucess");
                    clearController();
                  } else {
                    print('restart');
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
        confirmPassword.isEmpty) {
      return false;
    }

    // Vérification si le mot de passe et la confirmation du mot de passe sont identiques
    if (password != confirmPassword) {
      return false;
    }

    // Vérification si l'email est au bon format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return false;
    }

    // Si toutes les validations sont réussies, retourne true pour indiquer que le formulaire est valide
    return true;
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
