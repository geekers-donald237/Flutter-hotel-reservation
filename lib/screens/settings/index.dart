import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/avatar_card.dart';
import '../../widgets/settings_menu.dart';
import '../../widgets/support_card.dart';
import '../auth/edit_profile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  void openURL(String myUrl) async {
    var url = myUrl; // Remplacez par l'URL que vous souhaitez ouvrir
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir l\'URL : $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 AvatarCard(),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                Column(
                  children: [
                    SettingTile(title: AppLocalizations.of(context)!.personal_account, myicon: Icons.person, ontap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const EditProfile()),
                              (route) => false);
                    },),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Column(
                  children: [
                    SettingTile(title: AppLocalizations.of(context)!.terms_and_services, myicon: Icons.indeterminate_check_box_sharp, ontap: () { openURL('https://www.kitab-oo.com/terms-and-services'); },),
                    SettingTile(title: AppLocalizations.of(context)!.delete_my_account, myicon: Icons.delete_forever, ontap: () { openURL('https://www.kitab-oo.com/user-want-to-delete-account'); },),
                  ],
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