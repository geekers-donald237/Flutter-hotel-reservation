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
      //  home: isviewed != 0 ? OnBoard() : SplashScreen(),
      home: BottomBar(id: 0),
      builder: EasyLoading.init(),
    );
  }
}

// import 'package:find_hotel/widgets/app_text.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Bottom Sheet Example')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               builder: (BuildContext context) {
//                 return SortOptionsBottomSheet();
//               },
//             );
//           },
//           child: Text('Open Bottom Sheet'),
//         ),
//       ),
//     );
//   }
// }

// class SortOptionsBottomSheet extends StatefulWidget {
//   @override
//   _SortOptionsBottomSheetState createState() => _SortOptionsBottomSheetState();
// }

// class _SortOptionsBottomSheetState extends State<SortOptionsBottomSheet> {
//   Map<String, bool> sortOptions = {
//     'Logements entiers en premier': true,
//     'Distance du lieu d\'intérêt': false,
//     'Popularité': false,
//     'Catégorie (ordre croissant)': false,
//     'Catégorie (ordre décroissant)': false,
//     'Plus demandées': false,
//     'Tarif (du moins cher au plus cher)': false,
//   };

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double bottomSheetHeight = screenHeight * 4 / 5;

//     return Container(
//       height: bottomSheetHeight,
//       padding: EdgeInsets.all(20),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Trier par :',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 15),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: sortOptions.length,
//               itemBuilder: (BuildContext context, int index) {
//                 String option = sortOptions.keys.elementAt(index);
//                 return Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(option),
//                       Container(
//                         width: 24,
//                         height: 24,
//                         child: Checkbox(
//                           value: sortOptions[option],
//                           onChanged: (value) {
//                             setState(() {
//                               sortOptions[option] = value!;
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
