import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../models/DestinationModel.dart';
import '../models/HotelModel.dart';
import '../models/hotel_model.dart';
import '../screens/hotel/search/hotel/IndexHotelDetails.dart';
import '../screens/hotel/search/hotel/hotelDetailScreen.dart';
import '../urls/all_url.dart';
import 'app_text.dart';

class HotelCard extends StatefulWidget {
  const HotelCard({
    Key? key,
    required this.hotel,
    required this.destination_1
  }) : super(key: key);

  final HotelModels hotel;
  final DestinationModel destination_1;

  @override
  _HotelCardState createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndexHotelDetails(hotel: widget.hotel, destination_1: widget.destination_1,),
          ),
        );
      },
      child: Container(
        height: height * 0.3,
        child: Card(
          margin: EdgeInsets.all(6),
          elevation: 2,
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: height * 0.3, // Nouvelle hauteur de l'image
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child:
                      Image.network(
                          '${Urls.racine}imagesAccomodation/${widget.hotel.imagePath}',
                        fit: BoxFit.cover,
                        scale: 1.05,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.large(
                            widget.hotel.name!,
                            fontSize: 18,
                            textAlign: TextAlign.left,
                            maxLine: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppText.small("Appartement entier"),
                      ),
                      SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          spacing: 4,
                          children: [
                            AppText.small("Appartement entier"),
                            AppText.small("5 salles de bains"),
                            AppText.small("2 chambres"),
                            // Ajoutez d'autres caractéristiques ici
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppText.small("Tarif pour 1 nuit 2 adulte "),
                      ),
                      SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppText.large("\$${widget.hotel.minPrice} "),
                      ),
                      SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppText.small("Taxes et frais compris"),
                      ),
                      SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppText.small(
                          "Plus que 2 comme celui-ci",
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: 8),
                          AppText.small("Prépaiement requis"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
