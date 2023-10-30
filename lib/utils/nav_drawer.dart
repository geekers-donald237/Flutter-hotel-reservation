import 'package:find_hotel/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/auth/edit_profile.dart';
import '../urls/all_url.dart';
import 'Helpers.dart';
import 'about_us.dart';

class NavDrawer extends StatefulWidget {
  NavDrawer() : super();
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  // UserModel user;
  BuildContext? _context;
  _NavDrawerState() {
    super.initState();
  }

  String idu1 = '';
  String idu2 = '';
  String email1 = '';
  String email2 = '';
  String userName1 = '';
  String userName2 = '';

  Future<void> gett() async {
    idu2 = await getUserId();
    email2 = await getEmail();
    userName2 = await getUserName();
    setState(() {
      idu1 = idu2;
      email1 = email2;
      userName1 = userName2;
    });
  }

  @override
  void initState() {
    super.initState();
    gett();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userName1,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
            accountEmail: Text(email1),
            currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/logo/logo.png')),
            // decoration: new BoxDecoration(color: Colors.green),
          ),


          // ListTile(
          //   onTap: () {
          //     Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //             builder: (BuildContext context) => BugReportPage()));
          //   },
          //   leading: Icon(Icons.verified_outlined),
          //   title: Text(AppLocalizations.of(context)!.bug_repport),
          // ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const AboutPage()));
            },
            leading: Icon(Icons.badge),
            title: Text(AppLocalizations.of(context)!.drawer_propos),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (BuildContext context) =>
          //                 IndexKufuli_all_settings()));
          //   },
          //   leading: const Icon(Icons.settings),
          //   title: Text(AppLocalizations.of(context)!.setting),
          // ),
          ListTile(
            onTap: () {
              logout(context).then((value) => {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                        (route) => false)
              });
            },
            leading: const Icon(Icons.exit_to_app),
            title: Text("Exit"),
          ),
          ListTile(
            onTap: () async {
              const url = 'https://play.google.com/store/apps/details?id=fr.android.kufuli_pro';
              if (await canLaunch(url)) {
                await launch(
                  url,
                  forceSafariVC: true,
                  forceWebView: true,
                  enableJavaScript: true,
                );
              }
            },
            leading: const Icon(Icons.info_sharp),
            title:  const Text(
              Urls.appVersion,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
