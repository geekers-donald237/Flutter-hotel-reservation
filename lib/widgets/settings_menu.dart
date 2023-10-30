import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../gen/theme.dart';
import '../utils/Helpers.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final IconData myicon;
  final void Function()? ontap;
  const SettingTile({
    super.key,
    required this.title,
    required this.myicon,
    required this.ontap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap!, // Navigation
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: klightContentColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(myicon, color: kprimaryColor),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: kprimaryColor,
              fontSize: ksmallFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(
            CupertinoIcons.chevron_forward,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
}