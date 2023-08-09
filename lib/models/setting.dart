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
    title: "Credits Coupons",
    route: "/",
    icon: FontAwesomeIcons.gift,
  ),
];

final List<Setting> settings2 = [
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
