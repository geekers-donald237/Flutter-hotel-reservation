import 'package:find_hotel/utils/localfiles.dart';
import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../gen/theme.dart';
import '../models/hotel_model.dart';
import '../screens/hotel_screen.dart';
import 'app_text.dart';
import 'custom_rating.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
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
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
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
                      'hotel.title',
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
                        AppText.small('hotel.location'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: CustomRating(ratingScore: 5),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          AppTextSpan.large('\$15000'),
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
      ),
    );
  }
}

class OptionsShortcard extends StatelessWidget {
  const OptionsShortcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            //color: Colors.teal[800],
            color: primary,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Image.network(
                      "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/118898040/original/870e2763755963f5a300574bbea5977fa8b18460/sell-original-football-and-basketball-teams-jersey.jpg",
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 0.5,
                  height: 0,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 15,
                    ),
                    const Text(
                      "March 19, 2023",
                      style: TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.event, color: Colors.white),
                      onPressed: () {},
                    ),
                    Container(
                      width: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(width: 2),
        Expanded(
          flex: 1,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            color: primary,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 15,
                    ),
                    const Text(
                      "Call",
                      style: TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.call, color: Colors.white),
                      onPressed: () {},
                    ),
                    Container(
                      width: 4,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    "John Smith \nTek",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OptionsLongWidget extends StatelessWidget {
  const OptionsLongWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Define the shape of the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      // Define how the card's content should be clipped
      clipBehavior: Clip.antiAliasWithSaveLayer,
      // Define the child widget of the card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Add padding around the row widget
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Add an image widget to display an image
                Image.asset(
                  Localfiles.thumbnail1,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                // Add some spacing between the image and the text
                Container(width: 20),
                // Add an expanded widget to take up the remaining horizontal space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Add some spacing between the top of the card and the title
                      Container(height: 5),
                      // Add a title widget
                      Text(
                        "Cards Title 1",
                        style: MyTextSample.title(context)!.copyWith(
                          color: grey_80,
                        ),
                      ),
                      // Add some spacing between the title and the subtitle
                      Container(height: 5),
                      // Add a subtitle widget
                      Text(
                        "Sub title",
                        style: MyTextSample.body1(context)!.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                      // Add some spacing between the subtitle and the text
                      Container(height: 10),
                      // Add a text widget to display some text
                      Text(
                        MyStringsSample.card_text,
                        maxLines: 2,
                        style: MyTextSample.subhead(context)!.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionsCard extends StatelessWidget {
  const OptionsCard({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

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
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                  child: Image.asset(
                    Localfiles.thumbnail1,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Neecoder Cafe",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Cillum non aute elit cillum aliqua amet officia laboris ex sint. Non aliqua ex dolor anim. Officia aliqua minim aute id aliquip in occaecat et duis in Lorem adipisicing velit voluptate.",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
