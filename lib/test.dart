// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   GlobalKey<FormState> _formKey = GlobalKey();

//   FocusNode focusNode = FocusNode();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Phone Field Example'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: CustomPhoneField(formKey: _formKey, focusNode: focusNode),
//         ),
//       ),
//     );
//   }
// }




// class CustomPhoneField extends StatelessWidget {
//   CustomPhoneField({
//     Key? key,
//     required GlobalKey<FormState> formKey,
//     required this.focusNode,
//   }) : _formKey = formKey;

//   final GlobalKey<FormState> _formKey;
//   final FocusNode focusNode;

//   // Créez un contrôleur pour le champ IntlPhoneField
//   final TextEditingController _phoneController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(height: 10),
//           IntlPhoneField(
//             controller: _phoneController, // Lier le contrôleur au champ IntlPhoneField
//             focusNode: focusNode,
//             decoration: InputDecoration(
//               labelText: 'Phone Number',
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(),
//               ),
//             ),
//             languageCode: "en",
//             onChanged: (phone) {
//               // Vous n'avez plus besoin de cette partie dans onChanged
//               // phoneNumber = phone.completeNumber; // Mise à jour de la variable avec le numéro de téléphone entré
//               // print(phoneNumber); // Affichage du numéro de téléphone dans la console à chaque changement
//             },
//             onCountryChanged: (country) {
//               print('Country changed to: ' + country.name);
//             },
//           ),
//           SizedBox(height: 10),
//           MaterialButton(
//             child: Text('Submit'),
//             color: Theme.of(context).primaryColor,
//             textColor: Colors.white,
//             onPressed: () {
//               // Validation du formulaire
//               if (_formKey.currentState?.validate() == true) {
//                 // Récupérer la valeur du numéro de téléphone à partir du contrôleur
//                 String phoneNumber = _phoneController.text;
//                 print('Phone Number submitted: $phoneNumber'); // Affichage du numéro de téléphone lorsque le bouton "Submit" est pressé
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:find_hotel/gen/theme.dart';
import 'package:find_hotel/utils/localfiles.dart';
import 'package:find_hotel/widgets/custom_apbar.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xfff7f6fb),
      appBar: BuildAppbar('Reset Pwd'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  Localfiles.illustration3,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: kwhite,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: _textFieldOTP(first: true, last: false)),
                          SizedBox(width: 5),
                          Expanded(
                              child: _textFieldOTP(first: false, last: false)),
                          SizedBox(width: 5),
                          Expanded(
                              child: _textFieldOTP(first: false, last: false)),
                          SizedBox(width: 5),
                          Expanded(
                              child: _textFieldOTP(first: false, last: true)),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                    SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(kwhite),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kblack),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: kZambeziColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Resend New Code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kblack,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({required bool first, last}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
          ),
        ),
      ),
    );
  }
}
