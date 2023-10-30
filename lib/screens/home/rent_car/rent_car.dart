import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../models/card_model.dart';
import '../../../widgets/car_widget.dart';
import '../../car/available_cars.dart';
import '../../car/book_car.dart';
import '../../hotel/home/activity_screen.dart';

class RentCarScreen extends StatefulWidget {
  const RentCarScreen({super.key});

  @override
  State<RentCarScreen> createState() => _RentCarScreenState();
}

class _RentCarScreenState extends State<RentCarScreen> {
  bool isLoading = true;
  List<Car> getRandomcar() {
    final random = Random();

    if (Car.allCar.length <= 5) {
      // Si le tableau car a moins de 5 éléments, retourne le tableau original
      return Car.allCar;
    }

    List<Car> randomcar = [];
    while (randomcar.length < 5) {
      int randomIndex = random.nextInt(Car.allCar.length);

      if (!randomcar.contains(Car.allCar[randomIndex])) {
        randomcar.add(Car.allCar[randomIndex]);
      }
    }

    return randomcar;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // La charge est terminée
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                            AppLocalizations.of(context)!.top_deal,
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
                              child: Text(AppLocalizations.of(context)!
                                  .view_all_hotel))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: getRandomcar().map((item) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BookCar(car: item)),
                                );
                              },
                              child:
                              BuildHorizontalCard(item, 0, context));
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
    // for (var i = 0; i < car.length; i++) {
    for (var i = 0; i < 5; i++) {
      // je vais ajoute une implementation pour afficher les meilleurs deal a chaque fois.
      list.add(GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookCar(car: Car.allCar[i])),
            );
          },
          child: buildCar(Car.allCar[i], i)));
    }
    return list;
  }
}