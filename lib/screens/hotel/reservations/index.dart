import 'package:find_hotel/gen/theme.dart';
import 'package:find_hotel/utils/localfiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:ionicons/ionicons.dart';

import '../../../widgets/custom_icon_button.dart';


class ReservationIndex extends StatefulWidget {
  const ReservationIndex({super.key});

  @override
  State<ReservationIndex> createState() => _ReservationIndexState();
}

class _ReservationIndexState extends State<ReservationIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kblue,
        elevation: 1,
        title: Text('Voyage'),
        actions: const [
          CustomIconButton(
            icon: Icon(
              Icons.question_mark_rounded,
              color: kwhite,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 12),
            child: Icon(
              Ionicons.add,
              color: kwhite,
              size: 35,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Material(
                child: Container(
                  color: Colors.white,
                  height: 60,
                  child: TabBar(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.all(10),
                    unselectedLabelColor: kgrey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 237, 241, 243),
                      border: Border.all(color: kblue, width: 1),
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          height: 55,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(30),
                          //   border: Border.all(color: kblue, width: 1),
                          // ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.index_actif,
                              style: TextStyle(color: kblack),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 55,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(30),
                          //   border: Border.all(color: kblue, width: 1),
                          // ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.index_passes,
                              style: TextStyle(color: kblack),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 55,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(30),
                          //   border: Border.all(color: kblue, width: 1),
                          // ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.index_anul,
                              style: TextStyle(color: kblack),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: TabBarView(children: [
                ReservationWidget(
                  imagePath: Localfiles.OnboardImg1,
                  text: AppLocalizations.of(context)!.other_destination,
                ),
                ReservationWidget(
                  imagePath: Localfiles.OnboardImg2,
                  text: AppLocalizations.of(context)!.voyage_passe,
                ),
                ReservationWidget(
                  imagePath: Localfiles.OnboardImg3,
                  text: AppLocalizations.of(context)!.change_program,
                ),
              ]))
            ],
          )),
    );
  }
}

class ReservationWidget extends StatelessWidget {
  final String imagePath;
  final String text;

  const ReservationWidget({
    required this.imagePath,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
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
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
