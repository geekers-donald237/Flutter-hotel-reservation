import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../gen/theme.dart';
import '../utils/Helpers.dart';

class SupportCard extends StatelessWidget {
  const SupportCard({
    super.key,
  });
  void openURL(String myUrl, BuildContext context) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: myUrl, // Remplacez par l'adresse e-mail cible
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw AppLocalizations.of(context)!.impossible_to_compose_an_e_mail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: ksecondryLightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: (){
          openURL('contact@aloa-tech.com',context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.support_agent,
              size: 50,
              color: ksecondryColor,
            ),
            Text(
              AppLocalizations.of(context)!.feel_free_to_ask_we_ready_to_help,

              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: ksmallFontSize,
                color: ksecondryColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}