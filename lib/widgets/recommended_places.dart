import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../gen/theme.dart';
import '../models/hotel_model.dart';
import '../screens/hotel_screen.dart';
import 'app_text.dart';
import 'custom_rating.dart';

class RecommendedPlaces extends StatelessWidget {
  const RecommendedPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: HotelModel.sampleHotels.length,
      itemBuilder: (BuildContext context, int index) {
        HotelModel hotel = HotelModel.sampleHotels[index];
        return OptionCard(
          hotel: hotel,
        );
      },
    );
  }
}

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final HotelModel hotel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetailScreen(hotel: hotel),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                hotel.thumbnailPath,
                width: double.maxFinite,
                fit: BoxFit.cover,
                height: 150, // Ajuster la hauteur de l'image
              ),
            ),
          ),
          const SizedBox(height: 5),
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
                    hotel.title,
                    fontSize: 18,
                    textAlign: TextAlign.left,
                    maxLine: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Assets.icon.location.svg(
                        color: kgrey,
                        height: 15,
                      ),
                      const SizedBox(width: 8),
                      AppText.small(hotel.location),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: CustomRating(ratingScore: 5),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        AppTextSpan.large('\$${hotel.price}'),
                        AppTextSpan.medium(' /night'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
