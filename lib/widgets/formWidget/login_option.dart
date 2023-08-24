import 'package:find_hotel/utils/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/utils/localfiles.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class LoginOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BuildButton(
          iconImage: Image(
            height: 20,
            width: 20,
            image: AssetImage(Localfiles.apple),
          ),
          textButton: 'Apple', onpress: () {  },
        ),
        BuildButton(
          iconImage: Image(
            height: 20,
            width: 20,
            image: AssetImage(Localfiles.google),
          ),
          textButton: 'Google', onpress: signIn,
        ),
      ],
    );
  }
}

class BuildButton extends StatelessWidget {
  final Image iconImage;
  final Callback onpress;
  final String textButton;
  BuildButton({required this.iconImage, required this.textButton, required this.onpress});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: mediaQuery.height * 0.06,
        width: mediaQuery.width * 0.36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconImage,
            SizedBox(
              width: 5,
            ),
            Text(textButton),
          ],
        ),
      ),
    );
  }
}
