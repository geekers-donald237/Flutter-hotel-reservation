import 'package:find_hotel/gen/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class LocationListTitle extends StatelessWidget {
  final String location;
  final VoidCallback press;
  const LocationListTitle({super.key, required this.location, required this.press});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: Transform.rotate(
            angle: 45 * math.pi / 45,
            child: Icon(
              Icons.navigation,
              size: 20,
              color: kSecondaryColor,
            ),
          ),
          title: Text(location , maxLines: 2, overflow:  TextOverflow.ellipsis,),
        )
      ],
    );
  }
}
