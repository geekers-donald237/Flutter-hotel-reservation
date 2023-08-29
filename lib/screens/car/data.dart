import 'package:flutter/material.dart';


class Car {
  String brand;
  String model;
  double price;
  String condition;
  List<String> image;
  double ratingCar;

  Car(this.brand, this.model, this.price, this.condition, this.image,this.ratingCar);
}

List<Car> getCarList() {
  return <Car>[
    Car(
      "Land Rover",
      "Discovery",
      2580,
      "Weekly",
      [
        "assets/image/land_rover_0.png",
        "assets/image/land_rover_1.png",
        "assets/image/land_rover_2.png",
      ],
      4
    ),
    Car(
      "Alfa Romeo",
      "C4",
      3580,
      "Monthly",
      [
        "assets/image/alfa_romeo_c4_0.png",
      ],
      4
    ),
    Car(
      "Nissan",
      "GTR",
      1100,
      "Daily",
      [
        "assets/image/nissan_gtr_0.png",
        "assets/image/nissan_gtr_1.png",
        "assets/image/nissan_gtr_2.png",
        "assets/image/nissan_gtr_3.png",
      ],
      3
    ),
    Car(
      "Acura",
      "MDX 2020",
      2200,
      "Monthly",
      [
        "assets/image/acura_0.png",
        "assets/image/acura_1.png",
        "assets/image/acura_2.png",
      ],
      3
    ),
    Car(
      "Chevrolet",
      "Camaro",
      3400,
      "Weekly",
      [
        "assets/image/camaro_0.png",
        "assets/image/camaro_1.png",
        "assets/image/camaro_2.png",
      ],
      2
    ),
    Car(
      "Ferrari",
      "Spider 488",
      4200,
      "Weekly",
      [
        "assets/image/ferrari_spider_488_0.png",
        "assets/image/ferrari_spider_488_1.png",
        "assets/image/ferrari_spider_488_2.png",
        "assets/image/ferrari_spider_488_3.png",
        "assets/image/ferrari_spider_488_4.png",
      ],
      2
    ),
    Car(
      "Ford",
      "Focus",
      2300,
      "Weekly",
      [
        "assets/image/ford_0.png",
        "assets/image/ford_1.png",
      ],
      3
    ),
    Car(
      "Fiat",
      "500x",
      1450,
      "Weekly",
      [
        "assets/image/fiat_0.png",
        "assets/image/fiat_1.png",
      ],
      3
    ),
    Car(
      "Honda",
      "Civic",
      900,
      "Daily",
      [
        "assets/image/honda_0.png",
      ],
      3
    ),
    Car(
      "Citroen",
      "Picasso",
      1200,
      "Monthly",
      [
        "assets/image/citroen_0.png",
        "assets/image/citroen_1.png",
        "assets/image/citroen_2.png",
      ],
      3
    ),
  ];
}

class Dealer {
  String name;
  int offers;
  String image;

  Dealer(this.name, this.offers, this.image);
}

List<Dealer> getDealerList() {
  return <Dealer>[
    Dealer(
      "Hertz",
      174,
      "assets/image/hertz.png",
    ),
    Dealer(
      "Avis",
      126,
      "assets/image/avis.png",
    ),
    Dealer(
      "Tesla",
      89,
      "assets/image/tesla.jpg",
    ),
  ];
}

class Filter {
  String name;

  Filter(this.name);
}

List<Filter> getFilterList() {
  return <Filter>[
    Filter("Best Match"),
    Filter("Highest Price"),
    Filter("Lowest Price"),
  ];
}
