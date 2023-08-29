import 'dart:math';

import 'package:find_hotel/widgets/car_widget.dart';
import 'package:flutter/material.dart';

import 'available_cars.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'book_car.dart';
import 'data.dart';

class Showroom extends StatefulWidget {
  @override
  _ShowroomState createState() => _ShowroomState();
}

class _ShowroomState extends State<Showroom> {


  List<Car> cars = getCarList();

  List<Car> getRandomCars() {
    final random = Random();

    if (cars.length <= 5) {
      // Si le tableau cars a moins de 5 éléments, retourne le tableau original
      return cars;
    }

    List<Car> randomCars = [];
    while (randomCars.length < 5) {
      int randomIndex = random.nextInt(cars.length);

      if (!randomCars.contains(cars[randomIndex])) {
        randomCars.add(cars[randomIndex]);
      }
    }

    return randomCars;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Ex: Toyota',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.only(
                    left: 30,
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 24.0, left: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        print('je fais une recherche');
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top  Today Deals",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 280,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: buildDeals(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.recommendation,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AvailableCars()),
                                );
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.view_all_hotel))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: getRandomCars().map((item) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookCar(car: item)),
                                );
                              },
                              child: BuildHorizontalCard(item, 0));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildDeals() {
    List<Widget> list = [];
    // for (var i = 0; i < cars.length; i++) {
       for (var i = 0; i < 5; i++) { // je vais ajoute une implementation pour afficher les meilleurs deal a chaque fois.
      list.add(GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookCar(car: cars[i])),
            );
          },
          child: buildCar(cars[i], i)));
    }
    return list;
  }

}
