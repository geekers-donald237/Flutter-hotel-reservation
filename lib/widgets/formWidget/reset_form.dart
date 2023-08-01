import 'package:flutter/material.dart';

import '../../gen/theme.dart';

class ResetForm extends StatelessWidget {
  // Créez une variable pour stocker le contrôleur
  final TextEditingController emailController;

  // Le constructeur prend un contrôleur en paramètre
  ResetForm({required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: emailController, // Lier le contrôleur au champ TextFormField
        decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(color: kTextFieldColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
