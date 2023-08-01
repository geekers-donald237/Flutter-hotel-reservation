import 'package:flutter/material.dart';
import 'package:find_hotel/constants.dart';
import 'package:find_hotel/utils/localfiles.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Localfiles.profile,
          width: 80,
          height: 80,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "John Doe",
              style: TextStyle(
                fontSize: kbigFontSize,
                fontWeight: FontWeight.bold,
                color: kprimaryColor,
              ),
            ),
            Text(
              "View and edit profile",
              style: TextStyle(
                fontSize: ksmallFontSize,
                color: Colors.grey.shade600,
              ),
            )
          ],
        )
      ],
    );
  }
}
