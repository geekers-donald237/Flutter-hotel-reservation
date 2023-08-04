import 'package:find_hotel/screens/auth/login.dart';
import 'package:find_hotel/screens/auth/signup.dart';
import 'package:flutter/material.dart';

AppBar BuildAppbar(String message) {
  return AppBar(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 0,
    title: Text(message),
    centerTitle: true,
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " ",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    ],
  );
}

void redirect(BuildContext context, int index) {
  if (index == 1) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => LogInScreen(),
      ),
    );
  } else if (index == 2) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => SignUpScreen(),
      ),
    );
  } else if (index == 3) {
  } else if (index == 4) {
  } else {}
}
