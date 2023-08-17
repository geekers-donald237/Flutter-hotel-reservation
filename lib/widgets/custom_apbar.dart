
import 'package:flutter/material.dart';

import '../gen/theme.dart';

AppBar BuildAppbar(String message) {
  return AppBar(
    backgroundColor: ksecondryColor,
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
