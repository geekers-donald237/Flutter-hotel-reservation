import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:math' as Math;

import '../gen/theme.dart';
import '../widgets/custom_dialog.dart';

Future<bool> showCommonPopup(
    String title, String descriptionText, BuildContext context,
    {bool isYesOrNoPopup = false, bool barrierDismissible = true}) async {
  bool isOkClick = false;
  return await showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) => CustomDialog(
      title: title,
      description: descriptionText,
      onCloseClick: () {
        Navigator.of(context).pop();
      },
      actionButtonList: isYesOrNoPopup
          ? <Widget>[
              CustomDialogActionButton(
                buttonText: "NO",
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CustomDialogActionButton(
                buttonText: "YES",
                color: Colors.red,
                onPressed: () {
                  isOkClick = true;
                  Navigator.of(context).pop();
                },
              )
            ]
          : <Widget>[
              CustomDialogActionButton(
                buttonText: "OK",
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
    ),
  ).then((_) {
    return isOkClick;
  });
}


double deg2rad(double deg) {
    return deg * (3.141592653589793 / 180);
  }

  double getDistanceFromLatLonInKm(
      double lat1, double lon1, double lat2, double lon2) {
    final int R = 6371; // Rayon de la Terre en km
    final double dLat = deg2rad(lat2 - lat1);
    final double dLon = deg2rad(lon2 - lon1);
    final double a = (Math.sin(dLat / 2) * Math.sin(dLat / 2)) +
        (Math.cos(deg2rad(lat1)) *
            Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2));
    final double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    final double d = R * c; // Distance en km
    return d;
  }


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = kblue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}


