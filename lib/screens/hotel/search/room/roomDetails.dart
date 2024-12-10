import 'dart:convert';
import 'dart:io';

import 'package:find_hotel/models/room_Model.dart';
import 'package:find_hotel/widgets/app_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import '../../../../api/encrypt.dart';
import '../../../../models/DestinationModel.dart';
import '../../../../models/HotelModel.dart';
import '../../../../models/card_model.dart';
import '../../../../urls/all_url.dart';
import '../../../../utils/gallery_section.dart';
import '../../../../widgets/custom_number_input.dart';
import '/../gen/theme.dart';

class RoomDetails extends StatefulWidget {
  const RoomDetails({super.key,
    required this.room,
    required this.hotel,
    required this.destination_1,
  });
  final RoomModel room;
  final HotelModels hotel;
  final DestinationModel destination_1;

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  int _currentImage = 0;
  bool isFavorite = false;
  int dayDuration = 1;
  bool isLoading = true;
  List<String> room_list_imagePaths = [];


  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  getDetailHotel() async {
    try {
      var url = Uri.parse(Urls.hotel);
      final response = await http.post(url, body: {
        "id": encrypt(widget.room.id.toString()),
        "action": encrypt('get_room_details'),
      });
      // if (kDebugMode) {
      //   print(response.body);
      // }

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          isLoading = false;
        });
        // if (kDebugMode) {
        //   print(data['hotel_images']);
        // }
        room_list_imagePaths.clear();

        for(String i in data['hotel_images']){
          setState(() {
            room_list_imagePaths.add(i);
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } on SocketException {
      setState(() {
        isLoading = false;
      });
      EasyLoading.showInfo(AppLocalizations.of(context)!.verified_internet,
          duration: const Duration(seconds: 4));
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.showInfo(AppLocalizations.of(context)!.an_error_occur,
          duration: const Duration(seconds: 4));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kblue,
        foregroundColor: kblack,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            // child: Icon(
            //   isFavorite ? Icons.favorite : Icons.favorite_border,
            //   color: isFavorite ? Colors.red : Colors.black,
            //   size: 30,
            // ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.feedback,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(6.0),
          //   child: Container(
          //       width: 45,
          //       height: 45,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.all(
          //           Radius.circular(15),
          //         ),
          //         border: Border.all(
          //           color: Colors.grey[300]!,
          //           width: 1,
          //         ),
          //       ),
          //       child: Icon(
          //         Icons.share,
          //         color: Colors.black,
          //         size: 22,
          //       )),
          // ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '${widget.room.name}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Price',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        const Spacer(), // Utilisez Spacer pour occuper tout l'espace horizontal disponible
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.room.price.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: " XAF",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GallerySection(imagePaths: room_list_imagePaths,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText.large(
                                AppLocalizations.of(context)!.car_rent_day +
                                    " :"),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomNumberInput2(
                                value: dayDuration,
                                onDecrease: () {
                                  setState(() {
                                    if (dayDuration > 2) {
                                      dayDuration--;
                                    }
                                  });
                                },
                                onIncrease: () {
                                  setState(() {
                                    dayDuration++;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Text(
                      "SPECIFICATIONS",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    padding: EdgeInsets.only(
                      top: 8,
                      left: 16,
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildSpecificationCar("Color", "White"),
                        buildSpecificationCar("Gearbox", 'au'),
                        buildSpecificationCar("Seat", '2'),
                        buildSpecificationCar("Motor", "v10 2.0"),
                        buildSpecificationCar("Speed (0-100)", "3.2 sec"),
                        buildSpecificationCar("Top Speed", "121 mph"),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 16,
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.air_condition,
                            '0'),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.power_door,
                            'on'),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.anti_lock,
                            'on'),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.brake_assist,
                            'on'),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.drive_air_bag,
                           'on'),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.passenger_air_bag,
                            '0'),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.power_windows,
                            'on'),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.cd_player,
                            '0'),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.central_locking,
                            'on'),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.crash_sensor,
                            'on'),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.leather_s,
                            'on'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Book this car",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CarFeatureWidget(String title, String value) {
    return Card(
      elevation: 2, // Niveau d'élévation de la carte
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            if (value == 'on')
              Icon(Icons.check, color: Colors.green)
            else
              Icon(Icons.close, color: Colors.red),
            SizedBox(width: 8),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget buildSpecificationCar(String title, String data) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            data,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
