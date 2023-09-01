import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardModel {
  String img;
  String text;
  String desc;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
  });
}

class OnboardWidget extends StatelessWidget {
  final OnboardModel model;

  OnboardWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(model.img),
              Text(
                model.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'worksans',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                model.desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(
                height: 38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
