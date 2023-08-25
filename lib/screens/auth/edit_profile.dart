import 'package:find_hotel/gen/theme.dart';
import 'package:find_hotel/widgets/custom_apbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

import '../../widgets/formWidget/custom_phone_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

GlobalKey<FormState> _formKey = GlobalKey();
FocusNode focusNode = FocusNode();
bool _isObscure = true;

class _EditProfileState extends State<EditProfile> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pswController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbar(AppLocalizations.of(context)!.edit_btn + " profil"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 50),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // Alignement au centre

                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kgrey, // Couleur du bouton
                              elevation: 0, // Retire l'élévation
                            ),
                            onPressed: () {
                              clearController();
                            },
                            child: Text(AppLocalizations.of(context)!
                                .exit_response_non),
                          ),
                          SizedBox(width: 10), // Espace entre les boutons
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: green, // Couleur du bouton
                              elevation: 0, // Retire l'élévation
                            ),
                            onPressed: () {
                              // Action lorsque le bouton "Cancel" est pressé
                            },
                            child: Text(
                              AppLocalizations.of(context)!.edit_btn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearController() {
    emailController.clear();
    pswController.clear();
    phoneNumber = '';
    usernameController.clear();
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

  String phoneNumber =
      ""; // Variable pour stocker le numéro de téléphone dans ce widget

  void updatePhoneNumber(String newPhoneNumber) {
    // Fonction de rappel pour mettre à jour le numéro de téléphone dans ce widget
    phoneNumber = newPhoneNumber;
    print('Updated Phone Number: $phoneNumber');
  }
}
