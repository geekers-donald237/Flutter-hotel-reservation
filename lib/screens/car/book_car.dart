import 'package:find_hotel/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/card_model.dart';
import '../../widgets/custom_number_input.dart';
import '/../gen/theme.dart';

class BookCar extends StatefulWidget {
  final Car car;

  BookCar({required this.car});

  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<BookCar> {
  int _currentImage = 0;
  bool isFavorite = false;
  int dayDuration = 1;

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < widget.car.image.length; i++) {
      list.add(buildIndicator(i == _currentImage));
    }
    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400],
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: Icon(
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
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '${widget.car.vehiclesTitle} serie ${widget.car.modelYear} ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            widget.car.vehiclesOverview,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        Spacer(), // Utilisez Spacer pour occuper tout l'espace horizontal disponible
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.car.pricePerDay.toString(),
                                  style: TextStyle(
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
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: Container(
                        child: PageView(
                          physics: BouncingScrollPhysics(),
                          onPageChanged: (int page) {
                            setState(() {
                              _currentImage = page;
                            });
                          },
                          children: widget.car.image.map((path) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Hero(
                                tag: widget.car.vehiclesTitle,
                                child: Image.asset(
                                  path,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    widget.car.image.length > 1
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: buildPageIndicator(),
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
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
                        buildSpecificationCar(
                            "Gearbox", widget.car.powerSteering),
                        buildSpecificationCar(
                            "Seat", widget.car.seatingCapacity.toString()),
                        buildSpecificationCar("Motor", "v10 2.0"),
                        buildSpecificationCar("Speed (0-100)", "3.2 sec"),
                        buildSpecificationCar("Top Speed", "121 mph"),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: EdgeInsets.only(
                      top: 8,
                      left: 16,
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.air_condition,
                            widget.car.airConditioner),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.power_door,
                            widget.car.powerDoorLock),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.anti_lock,
                            widget.car.antiLockBrakingSystem),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.brake_assist,
                            widget.car.brakeAssist),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.drive_air_bag,
                            widget.car.driveAirBag),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.passenger_air_bag,
                            widget.car.passengerAirBag),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.power_windows,
                            widget.car.powerWindows),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.cd_player,
                            widget.car.cdPlayers),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.central_locking,
                            widget.car.centralLocking),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.crash_sensor,
                            widget.car.crashSensor),
                        CarFeatureWidget(
                            AppLocalizations.of(context)!.leather_s,
                            widget.car.leatherSeat),
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
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
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
