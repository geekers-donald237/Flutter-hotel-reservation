import 'dart:convert';
import 'dart:io';

import 'package:find_hotel/gen/theme.dart';
import 'package:find_hotel/screens/auth/login.dart';
import 'package:find_hotel/widgets/custom_apbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/encrypt.dart';
import '../../urls/all_url.dart';
import '../../utils/Helpers.dart';
import '../../utils/bottom_bar.dart';
import '../../widgets/formWidget/custom_phone_field.dart';
import '../../widgets/primary_button.dart';

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

  String idu1 = '';
  String idu2 = '';
  String email1 = '';
  String email2 = '';
  String userName1 = '';
  String userName2 = '';

  Future<void> gett() async {
    idu2 = await getUserId();
    email2 = await getEmail();
    userName2 = await getUserName();
    setState(() {
      idu1 = idu2;
      email1 = email2;
      userName1 = userName2;
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
    gett();
    super.initState();
    EasyLoading.dismiss();
  }


  change_password(String username,String email,String phone,String password) async {
    EasyLoading.show();
    var url = Uri.parse(Urls.user);
    try{

      if (kDebugMode) {
        print('ok');
      }
      //EasyLoading.showSuccess('status');
      final response = await http.post(url, body: {
        "action": encrypt("rentali_want_to_change_user_profil"),
        "good_email": encrypt(email1),
        "username": username == ''? '': encrypt(username),
        //"email": email == ''? '':encrypt(email),
        "phone": phone == ''? '':encrypt(phone),
        "password": password == ''? '':encrypt(password)
      });
      if (kDebugMode) {
        print(response.body);
      }
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        if(data['status'] == 'success'){
          EasyLoading.showSuccess(AppLocalizations.of(context)!.success_success);
          var user_detail = data['data'];
          String email = user_detail['email'];
          String id = user_detail['id'].toString();
          String user_name = user_detail['user_name'];
          String tel = user_detail['phone_number'];
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString('username', encrypt(user_name));
          await pref.setString('email', encrypt(email));
          await pref.setString('phone', encrypt(tel));
          await pref.setString('id', encrypt(id));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const BottomBar(id: 3,)),(route) => false);
        }else{
          if(data['message'] == 'no data send'){
            EasyLoading.showSuccess(AppLocalizations.of(context)!.please_fill_least_one_element);
          }if(data['message'] == 'user not exist'){
            EasyLoading.showError(AppLocalizations.of(context)!.email_not_exits);
            logout(context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LogInScreen()),(route) => false);
          }
        }
      }else{
        EasyLoading.showError(AppLocalizations.of(context)!.an_error_occur);
      }

    }on SocketException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.verified_internet)));
    }catch (e){
      print(e.toString());
      EasyLoading.showError(AppLocalizations.of(context)!.email_not_exits);
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const BottomBar(id: 3,)),(route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.profil_now),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const BottomBar(id: 3,)),(route) => false);
          }, icon: const Icon(Icons.backspace_outlined),),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child:
                Padding(
                  padding: kDefaultPadding,
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                      ))),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                    ),
                                    color: Colors.green,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      buildInputForm(
                          userName1,
                          false,
                          usernameController),
                      buildInputForm(email1, false, emailController),
                      // buildInputForm('Phone', false, phoneController),
                      CustomPhoneField(
                        formKey: _formKey,
                        focusNode: focusNode,
                        onPhoneNumberChanged: updatePhoneNumber,
                        phoneNumber: phoneNumber,
                      ),
                      buildInputForm(
                      '***************',
                          true, pswController),
                      Padding(padding: const EdgeInsets.all(8)
                      ,child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                clearController();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height * 0.08,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16), color: kgrey),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .clear_all,
                                  style: textButton.copyWith(color: kWhiteColor),
                                ),
                              ),
                            ),

                            SizedBox(height: 10), // Espace entre les boutons

                            MaterialButton(
                              onPressed: () {
                                change_password(usernameController.text,emailController.text,phoneNumber,pswController.text);
                              },
                              textColor: Colors.white,
                              color: Colors.green,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  AppLocalizations.of(context)!.edit_btn,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              height: 50,
                              minWidth: 600,
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: textEditingController,
          obscureText: pass ? _isObscure : false,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: kTextFieldColor),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
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
    if (kDebugMode) {
      print('Updated Phone Number: $phoneNumber');
    }
  }
}
