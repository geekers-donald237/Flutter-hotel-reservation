import 'package:find_hotel/test.dart';
import 'package:find_hotel/utils/bottom_bar.dart';
import 'package:find_hotel/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'gen/theme.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'onboard/onboard.dart';
import 'onboard/splashScreen.dart';

// import 'package:localizations/l10n/l10n.dart';

int? isviewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  Stripe.publishableKey =
      "pk_test_51LjocGK8ksAoxFf2T3BnkDu57BM1Kk0KEh5Y8iOOSNS3gH0liQx46AKTKh22UfOum4EtUC5pbHsnR5PfXbwJ2MtD00v11UEdVv";

  await FlutterConfig.loadEnvVariables();
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
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
        visualDensity: VisualDensity.adaptivePlatformDensity,

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
      // home: BottomBar(id: 0),
      builder: EasyLoading.init(),
    );
  }
}
