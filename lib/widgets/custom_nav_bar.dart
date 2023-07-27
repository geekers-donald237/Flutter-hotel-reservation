import 'package:flutter/material.dart';
import 'package:flutter_hotel_app_ui/utils/localfiles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../gen/theme.dart';
import '../screens/home_screen.dart';
import '../screens/map_screen.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavBarIcon(
              iconPath: Localfiles.home,
              text: 'Home',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => HomeScreen()),
                  ),
                );
              },
              isSelected: index == 0,
            ),
            _NavBarIcon(
              iconPath: Localfiles.map,
              text: 'Map',
              isSelected: index == 1,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => MapScreen()),
                  ),
                );
              },
            ),
            _NavBarIcon(
              iconPath: Localfiles.booking,
              text: 'Booking',
            ),
            _NavBarIcon(
              iconPath: Localfiles.profile,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  const _NavBarIcon({
    Key? key,
    required this.iconPath,
    required this.text,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final String iconPath;
  final String text;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? ColorName.primaryColor : ColorName.lightGrey;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconPath, color: color),
          const SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontFamily: FontFamily.workSans,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
