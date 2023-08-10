import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
