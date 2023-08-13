import 'package:flutter/material.dart';
import '../gen/theme.dart';
import 'app_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
  }) : super(key: key);

  final String buttonText;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(kblue),
        minimumSize: MaterialStateProperty.all(const Size(200, 50)),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
            vertical: 2,
            horizontal:
                25)), // Ajustez les valeurs de padding comme vous le souhaitez
      ),
      child: AppText.medium(
        buttonText,
        fontSize: 16,
      ),
    );
  }
}
