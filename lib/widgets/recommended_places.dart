import 'package:find_hotel/utils/localfiles.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:find_hotel/models/recommended_places_model.dart';

import '../gen/assets.gen.dart';
import '../gen/theme.dart';
import 'app_text.dart';
import 'custom_rating.dart';

class RecommendedPlaces extends StatelessWidget {
  const RecommendedPlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 220,
            child: Card(
              elevation: 0.4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          child: Image.asset(Localfiles.OnboardImg1,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                              height: 100),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        flex: 1,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
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
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.only(right: 10),
        ),
        itemCount: recommendedPlaces.length,
      ),
    );
  }
}
