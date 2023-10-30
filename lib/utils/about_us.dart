import 'package:find_hotel/utils/subTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../routes/route_names.dart';
import '../urls/all_url.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        NavigationServices(context).gotoBottomScreen(0);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.drawer_propos),
          leading: IconButton(
            onPressed: () {
              NavigationServices(context).gotoBottomScreen(0);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Kitaboo",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF303030),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/logo/logo.png',
                      height: 100,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        Urls.appVersion,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF303030),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SubTitle(
                subTitleText: 'Copyrith PiAloa-Tech',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
