import 'package:find_hotel/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/routes/route_names.dart';
import 'package:ionicons/ionicons.dart';
import '../gen/theme.dart';
import '../screens/home_screen.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavBarIcon(
              icon: Ionicons.home_outline,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => HomeScreen()),
                  ),
                );
              },
              isSelected: widget.index == 0,
            ),
            _NavBarIcon(
              icon: Ionicons.heart_outline,
              isSelected: widget.index == 1,
              onTap: () {
                
              },
            ),
            _NavBarIcon(
              icon: Ionicons.ticket_outline,
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
    required this.icon,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final IconData icon;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? kblue : kblack;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(height: 5),
            // Text(
            //   text,
            //   style: TextStyle(
            //     fontSize: 10,
            //     fontFamily: FontFamily.workSans,
            //     fontWeight: FontWeight.w400,
            //     color: color,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
