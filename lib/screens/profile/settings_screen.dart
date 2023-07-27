import 'package:flutter/material.dart';
import 'package:flutter_hotel_app_ui/gen/theme.dart';

import '../../models/setting_list_data.dart';
import '../../routes/route_names.dart';
import '../../utils/helper.dart';
import '../../widgets/common_appbar_view.dart';
import '../../widgets/remove_focuse.dart';
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>  {
  List<SettingsListData> settingsList = SettingsListData.settingsList;
  var country = 'Australia';
  var currency = '\$ AUD';
  int selectedradioTile = 0;
  List<String> data = ["English", "French", "Arabic", "Japanese"];

  @override
  Widget build(BuildContext context) {
 
        return Scaffold(
          body: RemoveFocuse(
            onClick: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonAppbarView(
                  iconData: Icons.arrow_back,
                  onBackClick: () {
                    Navigator.pop(context);
                  },
                  titleText: "setting_text",
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 16),
                    itemCount: settingsList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (index == 1) {
                            // MyApp.restartApp(context);
                          } else if (index == 6) {
                            NavigationServices(context)
                                .gotoCurrencyScreen()
                                .then((value) {
                              if (value is String && value != "")
                                setState(() {
                                  currency = value;
                                });
                            });
                          } else if (index == 5) {
                            NavigationServices(context)
                                .gotoCountryScreen()
                                .then((value) {
                              if (value is String && value != "") {
                                setState(() {
                                  country = value;
                                });
                              }
                            });
                          } else if (index == 2) {
                            // _getFontPopUI();
                          } else if (index == 3) {
                            // _getColorPopUI();
                          } else if (index == 4) {
                            // _getLanguageUI();
                          } else if (index == 10) {
                            _gotoSplashScreen();
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, right: 16),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                      settingsList[index].titleTxt,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  index == 5
                                      ? Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: getTextUi(country))
                                      : index == 6
                                          ? Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: getTextUi(currency),
                                              //   child:
                                            )
                                          : Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Container(
                                                    child: Icon(
                                                        settingsList[index]
                                                            .iconData,
                                                        color:kSecondaryColor),
                                                  ),
                                                )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Divider(
                                height: 1,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      
    
  }

 
  Widget getTextUi(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
              fontSize: 16,
            ),
      ),
    );
  }

  Widget _getSelectedUI(IconData icon, String text, bool isCurrent) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color:
                isCurrent ? kPrimaryColor : kSecondaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              text,
              style: TextStyle(
                    color: isCurrent
                        ? kPrimaryColor
                        : kSecondaryColor,
                  ),
            ),
          )
        ],
      ),
    );
  }

 
 
  void _gotoSplashScreen() async {
    bool isOk = await showCommonPopup(
      "Are you sure?",
      "You want to Sign Out.",
      context,
      barrierDismissible: true,
      isYesOrNoPopup: true,
    );
    if (isOk) {
      NavigationServices(context).gotoSplashScreen();
    }
  }
}
