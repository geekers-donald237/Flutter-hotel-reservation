import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Setting {
  final String title;
  final String route;
  final IconData icon;

  Setting({
    required this.title,
    required this.route,
    required this.icon,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Change Password",
    route: "/",
    icon: FontAwesomeIcons.lock,
  ),
  Setting(
    title: "Credits Coupons",
    route: "/",
    icon: FontAwesomeIcons.gift,
  ),
];

final List<Setting> settings2 = [
  Setting(
    title: "Payement text",
    route: "/",
    icon: CupertinoIcons.ellipsis_vertical_circle_fill,
  ),
  Setting(
    title: "Invite Friend",
    route: "/",
    icon: FontAwesomeIcons.wallet,
  ),
  Setting(
    title: "Settings",
    route: "/",
    icon: Icons.settings,
  ),
];
