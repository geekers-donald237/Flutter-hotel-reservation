import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardModel {
  String img;
  String text;
  String desc;
  Color bg;
  Color button;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
    required this.bg,
    required this.button,
  });
}



class OnboardWidget extends StatelessWidget {
  final OnboardModel model;

  OnboardWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(model.img),
            Text(
              model.text,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              model.desc,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            // Vous pouvez ajouter d'autres widgets pour afficher les propriétés de votre modèle.
          ],
        ),
      ),
    );
  }
}
