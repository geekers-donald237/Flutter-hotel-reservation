import 'package:find_hotel/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/routes/route_names.dart';
import '../gen/theme.dart';
import '../screens/home_screen.dart';
import '../screens/map_screen.dart';

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
              icon: CupertinoIcons.search,
              text: 'Rechercher',
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
              icon: CupertinoIcons.heart,
              text: 'Favoris',
              isSelected: widget.index == 1,
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
              icon: Icons.playlist_add_check_sharp,
              text: 'Reservations',
            ),
            _NavBarIcon(
              icon: CupertinoIcons.person,
              text: 'Profile',
              isSelected: widget.index == 3,
              onTap: () {
                NavigationServices(context).gotoProfileScreen();
              },
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
    required this.text,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final IconData icon;
  final String text;
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
            const SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                fontSize: 10,
                fontFamily: FontFamily.workSans,
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
