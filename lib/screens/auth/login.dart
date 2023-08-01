import 'package:flutter/material.dart';
import 'package:find_hotel/screens/auth/forgot_password.dart';
import 'package:find_hotel/screens/auth/signup.dart';

import 'package:find_hotel/widgets/primary_button.dart';

import '../../gen/theme.dart';
import '../../widgets/custom_apbar.dart';
import '../../widgets/formWidget/login_option.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pswController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbar('Login'),
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
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: textButton.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                      ),
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
                    clearController();
                  } else {
                    print('nope');
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Or log in with:',
                style: subTitle.copyWith(color: kBlackColor),
              ),
              SizedBox(
                height: 20,
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
}
