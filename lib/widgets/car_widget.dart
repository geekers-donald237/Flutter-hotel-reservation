import 'package:find_hotel/gen/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/card_model.dart';
import 'app_text.dart';
import 'custom_rating.dart';

Widget BuildHorizontalCard(Car car, int index, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: kwhite,
      border: Border.all(
        color: Colors.black, // Couleur de la bordure
        width: 3, // Largeur de la bordure
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
              child: Image.asset(
                car.image[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10), // Ajoute de l'espace entre les Flexible
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.large(
                    car.vehiclesTitle,
                    fontSize: 18,
                    textAlign: TextAlign.left,
                    maxLine: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: CustomRating(ratingScore: 3),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        AppTextSpan.large('\$${car.pricePerDay}'),
                        AppTextSpan.medium(
                            ' /${AppLocalizations.of(context)!.day}'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildCar(Car car, int index) {
  return Container(
    decoration: BoxDecoration(
      color: kgrey,
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.only(
        right: index != null ? 16 : 0, left: index == 0 ? 16 : 0),
    width: 220, // Augmenter la largeur du conteneur
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            // child: Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //   child: Text(
            //     car.condition,
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 12,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 120,
          child: Center(
            child: Hero(
              tag: car.vehiclesTitle,
              child: Image.asset(
                car.image[0],
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${car.vehiclesTitle} ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'serie :  ${car.modelYear}',
          style: TextStyle(fontSize: 18),
        ),
        // SizedBox(
        //   height: 8,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            for (int i = 1; i <= 5; i++)
              Icon(
                Icons.star,
                color: i <= 3 ? yellow : Colors.white,
              ),
            const SizedBox(width: 12),
          ],
        ),
      ],
    ),
  );
}
