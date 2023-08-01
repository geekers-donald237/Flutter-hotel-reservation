import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/constants.dart';
import 'package:find_hotel/models/setting.dart';
import 'package:find_hotel/widgets/avatar_card.dart';
import 'package:find_hotel/widgets/setting_tile.dart';
import 'package:find_hotel/widgets/support_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AvatarCard(),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                Column(
                  children: List.generate(
                    settings.length,
                    (index) => SettingTile(setting: settings[index]),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Column(
                  children: List.generate(
                    settings2.length,
                    (index) => SettingTile(setting: settings2[index]),
                  ),
                ),
                const SizedBox(height: 20),
                const SupportCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
