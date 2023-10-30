import 'package:flutter/material.dart';

import '../gen/theme.dart';
import '../utils/Helpers.dart';

class AvatarCard extends StatefulWidget {
  AvatarCard() : super();
  @override
  _AvatarCardState createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
BuildContext? _context;
_AvatarCardState() {
  super.initState();
}

  String idu1 = '';
  String idu2 = '';
  String email1 = '';
  String email2 = '';
  String userName1 = '';
  String userName2 = '';

  Future<void> gett() async {
    idu2 = await getUserId();
    email2 = await getEmail();
    userName2 = await getUserName();
    setState(() {
      idu1 = idu2;
      email1 = email2;
      userName1 = userName2;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    gett();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/logo/logo.png",
          width: 80,
          height: 80,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              userName1,
              style: const TextStyle(
                fontSize: kbigFontSize,
                fontWeight: FontWeight.bold,
                color: kprimaryColor,
              ),
            ),
            Text(
              email1,
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