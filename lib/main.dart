import 'package:find_hotel/api/encrypt.dart';
import 'package:find_hotel/screens/auth/signup.dart';
import 'package:find_hotel/screens/home_screen.dart';
import 'package:find_hotel/utils/currentuser.dart';
import 'package:find_hotel/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'gen/theme.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'onboard/onboard.dart';
import 'onboard/splashScreen.dart';

// import 'package:localizations/l10n/l10n.dart';

int? isviewed;
String? email_share_preference;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await FlutterConfig.loadEnvVariables();
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  email_share_preference = decrypt(prefs.getString('email').toString());
  isviewed = prefs.getInt('onBoard');
  runApp(const ProviderScope(child: MyApp()));
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Hotel',
      theme: ThemeData(
        scaffoldBackgroundColor: kwhite,
        // fontFamily: FontFamily.workSans,
        // primarySwatch: kprimaryCol,
      ),

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: L10n.all,
       home: isviewed != 0 ? OnBoard() : SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
