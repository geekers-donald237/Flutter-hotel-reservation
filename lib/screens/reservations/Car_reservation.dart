import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../../models/hotel_model.dart';
import '../../../utils/Helpers.dart';
import '../../../utils/localfiles.dart';


class CarReservation extends StatefulWidget {
  const CarReservation(
      {Key? key,})
      : super(key: key);

  @override
  _CarReservationState createState() => _CarReservationState();
}

enum Mytype { periode, permanent }

class _CarReservationState extends State<CarReservation> {
  _CarReservationState() {
    super.initState();
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController controller;
  String name = '';
  String nameCostum = '';
  String nameOfBelongCode = '';

  String start = '';
  String end = '';
  DateTime? selectedStartDateTime, selectedEndDateTime;

  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
  int endDates = 0;
  int startDates = 0;


  List<HotelModel> _lockList = [];
  String smg = '';
  bool _loading = true;
  String img = 'assets/lottie/not_found.json';

  //resolu pour le cryptage
  getData() async {
    // setState(() {
    //   img = Localfiles.OnboardImg1;
    //   smg = AppLocalizations.of(context)!.you_dont_have_reservation_from_now;
    // });


    // var res = await getLock(idSerrure);
    // print(res);
    // try {
    //   var data = res[0];
    //   if (data['message'] == 'empty') {
    //     setState(() {
    //       img = "assets/images/14_No_Search_Results.png";
    //       smg = AppLocalizations.of(context)!.you_dont_have_reservation_from_now;
    //     });
    //   } else if (data['message'] == 'error') {
    //   } else {
    //     // _lockList.clear();
    //     // for (Map i in res) {
    //     //   setState(() {
    //     //     _loading = false;
    //     //     _lockList.add(CostumCodeModel.fromJson(i));
    //     //   });
    //     // }
    //   }
    // } on SocketException catch (e) {
    //   setState(() {
    //     img = "assets/images/14_No_Search_Results.png";
    //     smg = AppLocalizations.of(context)!.verified_internet;
    //   });
    //   EasyLoading.showError(AppLocalizations.of(context)!.verified_internet);
    // } catch (e) {
    //   setState(() {
    //     img = "assets/images/14_No_Search_Results.png";
    //     smg = AppLocalizations.of(context)!.an_error_occur;
    //   });
    //   print(e);
    //   EasyLoading.showError(AppLocalizations.of(context)!.an_error_occur);
    // }
  }

  String idadmin1 = '';
  String idadmin2 = '';
  String email1 = '';
  String email2 = '';
  String userName1 = '';
  String userName2 = '';

  Future<void> gett() async {
    idadmin2 = await getUserId();
    email2 = await getEmail();
    userName2 = await getUserName();
    setState(() {
      idadmin1 = idadmin2;
      email1 = email2;
      userName1 = userName2;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    gett();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading == true
          ? Center(
        child: Column(
          children: [
            SizedBox(height: 45,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Lottie.asset(
                img,
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 25,),
            Text(
              AppLocalizations.of(context)!.you_dont_have_reservation_from_now,
              style: TextStyle(fontSize: 22, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ) : ListView.builder(
        itemCount: _lockList.length,
        itemBuilder: (BuildContext context, index) {
          final lock = _lockList[index];
          return Card(
            elevation: 10.0,
            child: ListTile(
              title: Text(''),
              subtitle: Text(''),
              onTap: () {
              },
            ),
          );
        },
      ),

      // return  Center(child: CircularProgressIndicator(),);
    );
  }
}
