
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/room_Model.dart';
import '../urls/all_url.dart';
import '../utils/Helpers.dart';

class PlaceWidget extends StatelessWidget {
  final RoomModel? item;
  final Animation<double>? animation;
  final AnimationController? animationController;
  const PlaceWidget({ Key? key , this.item, this.animation, this.animationController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController!,

        builder: (context, child) {
          return FadeTransition(
            opacity: animation!,

            child: Transform(
              transform: Matrix4.translationValues(0, 50 * (1 - animation!.value), 0),
              child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 25, right: 25, top:8, bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4,4),
                              blurRadius: 16
                          )
                        ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network('${Urls.racine}imagesAccomodation/${item!.imagePath!}',
                                fit: BoxFit.cover,
                                scale: 1.05,
                              ),
                            ),

                            Container(
                              color: Colors.white,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 16, bottom: 8, top: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(item!.name!,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(item!.surface_area.toString(), style: TextStyle(
                                                  color: Colors.black.withOpacity(0.4),
                                                  fontSize: 14
                                              ),),
                                              const SizedBox(width: 5,),
                                              const Icon(
                                                FontAwesomeIcons.locationDot,
                                                size: 13,
                                                color: primaryColor,
                                              ),

                                            ],
                                          ),

                                          Container(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Row(
                                                children: [

                                                  RatingBar(
                                                      initialRating: 21,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 24,
                                                      ratingWidget: RatingWidget(
                                                          full: const Icon(Icons.star_rate_rounded, color: primaryColor,),
                                                          half: const Icon(Icons.star_half_rounded, color: primaryColor,),
                                                          empty: const Icon(Icons.star_border_rounded, color: primaryColor,)
                                                      ),
                                                      itemPadding: EdgeInsets.zero,
                                                      onRatingUpdate: (value) {

                                                      }
                                                  ),
                                                  Text("321 Reviews",
                                                    style: TextStyle(
                                                        color: Colors.black.withOpacity(0.4),
                                                        fontSize: 14
                                                    ),)
                                                ]
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                      padding: EdgeInsets.only(right: 16, top: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("\$${item!.price}", style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22
                                          ),),
                                          Text("/ per night", style: TextStyle(
                                              color: Colors.black.withOpacity(0.4),
                                              fontSize: 14
                                          ))
                                        ],)
                                  )


                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            ),
          );
        }
    );
  }
}