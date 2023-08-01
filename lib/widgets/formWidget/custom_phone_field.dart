import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneField extends StatelessWidget {
  const CustomPhoneField({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.focusNode,
    required this.phoneNumber, // Ajout de la variable phoneNumber comme paramètre du constructeur
    required this.onPhoneNumberChanged, // Callback pour notifier l'autre widget du changement du numéro de téléphone
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final FocusNode focusNode;
  final String
      phoneNumber; // Variable pour stocker le numéro de téléphone entré
  final Function(String)
      onPhoneNumberChanged; // Callback pour notifier l'autre widget du changement du numéro de téléphone

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          IntlPhoneField(
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              // border: OutlineInputBorder(
              //   borderSide: BorderSide(),
              // ),
            ),
            languageCode: "en",
            initialValue:
                phoneNumber, // Utilisation de la variable phoneNumber comme valeur initiale
            onChanged: (phone) {
              onPhoneNumberChanged(phone
                  .completeNumber); // Utilisation du callback pour notifier l'autre widget du changement du numéro de téléphone
            },
            onCountryChanged: (country) {
              print('Country changed to: ' + country.name);
            },
          ),
        ],
      ),
    );
  }
}
