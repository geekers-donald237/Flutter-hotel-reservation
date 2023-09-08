import 'package:find_hotel/utils/localfiles.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../gen/theme.dart';

class FavorisScreen extends StatefulWidget {
  const FavorisScreen({super.key});

  @override
  State<FavorisScreen> createState() => _FavorisScreenState();
}

class _FavorisScreenState extends State<FavorisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kblue,
        elevation: 1,
        title: Text(AppLocalizations.of(context)!.find_the_best_deal),
      ),
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.2,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Localfiles.illustration3,
                      width: MediaQuery.of(context).size.width * 0.8,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 13),
                            blurRadius: 25,
                            color: Color(0xFFD27E4A).withOpacity(0.17),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.fav_save,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            AppLocalizations.of(context)!.fav_create,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                              // style: ButtonStyle(
                              //   elevation: 0,
                              //   shape: Borde
                              // ),
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context)!.fav_create_liste,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
