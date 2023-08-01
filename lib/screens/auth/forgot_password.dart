import 'package:find_hotel/screens/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/widgets/primary_button.dart';

import '../../gen/theme.dart';
import '../../widgets/custom_apbar.dart';
import '../../widgets/formWidget/reset_form.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();

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
                'Reset Password',
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
                  if (validateEmail(emailcontroller.text)) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Otp()));
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

  bool validateEmail(String value) {
    if (value.isEmpty) {
      return false; // Message d'erreur si l'email est vide
    }

    // Vérification si l'email est au bon format en utilisant une expression régulière
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return false; // Message d'erreur si l'email est incorrect
    }

    return true; // Validation réussie, retourne null
  }
}
