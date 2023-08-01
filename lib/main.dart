import 'package:find_hotel/screens/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:find_hotel/screens/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'gen/theme.dart';
import 'onboard/onboard.dart';
// import 'package:localizations/l10n/l10n.dart';

int? isviewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await FlutterConfig.loadEnvVariables();
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hotel App',
      theme: ThemeData(
        fontFamily: FontFamily.workSans,
        primarySwatch: ColorName.primarySwatch,
      ),
      // localizationsDelegates: [
      //   // AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // home: isviewed != 0 ? OnBoard() : HomeScreen(),
      home: SignUpScreen(),
    );
  }
}
