import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../gen/theme.dart';
import '../models/HotelModel.dart';
import '../models/hotel_model.dart';
import '../screens/hotel/search/hotel/hotelDetailScreen.dart';
import 'app_text.dart';
import 'custom_rating.dart';

class RecommendedPlaces extends StatelessWidget {
  const RecommendedPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: buildHotelDeal(),
      ),
    );
  }
}

List<Widget> buildHotelDeal() {
  List<Widget> list = [];
  for (var i = 0; i < HotelModel.sampleHotels.length; i++) {
    // list.add(
    //   GestureDetector(
    //     onTap: () {},
    //     child: OptionCard(
    //       hotel: HotelModel.sampleHotels[i],
    //     ),
    //   ),
    // );
  }
  return list;
}

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final HotelModels hotel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HotelDetailScreen(hotel: hotel),
        //   ),
        // );
      },
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Flexible(
      //       flex: 2,
      //       child: ClipRRect(
      //         borderRadius: BorderRadius.vertical(
      //           top: Radius.circular(12),
      //         ),
      //         child: Image.asset(
      //           hotel.thumbnailPath,
      //           width: double.maxFinite,
      //           fit: BoxFit.cover,
      //           height: 150, // Ajuster la hauteur de l'image
      //         ),
      //       ),
      //     ),
      //     const SizedBox(height: 5),
      //     Flexible(
      //       flex: 2,
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 12.0),
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             AppText.large(
      //               hotel.title,
      //               fontSize: 18,
      //               textAlign: TextAlign.left,
      //               maxLine: 2,
      //               textOverflow: TextOverflow.ellipsis,
      //             ),
      //             const SizedBox(height: 4),
      //             Row(
      //               children: [
      //                 Assets.icon.location.svg(
      //                   color: kgrey,
      //                   height: 15,
      //                 ),
      //                 const SizedBox(width: 8),
      //                 AppText.small(hotel.location),
      //               ],
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(vertical: 12),
      //               child: CustomRating(ratingScore: 5),
      //             ),
      //             RichText(
      //               text: TextSpan(
      //                 children: [
      //                   AppTextSpan.large('\$${hotel.price}'),
      //                   AppTextSpan.medium(' /night'),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

      child: Container(
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.only(
          right: 16,
        ),
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    hotel.name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 150,
              child: Center(
                child: Hero(
                  tag: hotel.contactEmail!,
                  child: Image.asset(
                    hotel.imagePath!,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    height: 150, // Ajuster la hauteur de l'image
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AppText.small(hotel.address!),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                children: [
                  AppTextSpan.medium('\$${hotel.minPrice}'),
                  AppTextSpan.medium(' /night'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // for (int i = 1; i <= 5; i++)
                //   Icon(
                //     Icons.star,
                //     color: i <= hotel.nbStars ? yellow : Colors.white,
                //   ),
                const SizedBox(width: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
