import 'package:flutter/material.dart';

import '../../gen/theme.dart';
import '../../widgets/custom_apbar.dart';
import '../../widgets/primary_button.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

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
                ontap: () {},
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

  bool arePasswordsEqual(String password1, String password2) {
    return password1 == password2;
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
}
