import 'package:flutter/material.dart';

import '../../gen/theme.dart';
import '../../models/card_model.dart';
import '../../widgets/car_widget.dart';
import 'book_car.dart';

class AvailableCars extends StatefulWidget {
  @override
  _AvailableCarsState createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kblue,
        foregroundColor: kblack,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Available Cars (" + Car.allCar.length.toString() + ")",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.sort_sharp), // Icône des trois points verticaux
            onSelected: (value) {
              // Fonction appelée lorsque l'utilisateur sélectionne un élément
              // Ajoutez ici la logique pour trier les voitures en fonction de la valeur sélectionnée
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'sortByPrice',
                child: Text('Sort by Price'),
              ),
              PopupMenuItem<String>(
                value: 'sortByRating',
                child: Text('Sort by Rating'),
              ),
              // Ajoutez d'autres éléments de tri si nécessaire
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: Car.allCar.map((item) {
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
      ),
    );
  }
}
