
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../gen/theme.dart';

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
              icon: Ionicons.search,
              onTap: () {
                
              },
              isSelected: widget.index == 0,
              text: 'Rechercher',
            ),
            _NavBarIcon(
              icon: Ionicons.heart_outline,
              isSelected: widget.index == 1,
              onTap: () {},
              text: 'Favoris',
            ),
            _NavBarIcon(
              icon: Ionicons.ticket_outline,
              text: 'Reservations',
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
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final Function()? onTap;
  final bool isSelected;
  final String text;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? kblue : kblack;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 25,
            ),
            SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
