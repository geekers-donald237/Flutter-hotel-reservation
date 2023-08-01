import 'package:flutter/material.dart';
import 'package:find_hotel/constants.dart';

class SupportCard extends StatelessWidget {
  const SupportCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: ksecondryLightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          print('ouverture d\'un lien');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(
              Icons.support_agent,
              size: 50,
              color: ksecondryColor,
            ),
            SizedBox(width: 10),
            Text(
              "Feel Free to Ask, We Ready to Help",
              style: TextStyle(
                fontSize: ksmallFontSize,
                color: ksecondryColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
