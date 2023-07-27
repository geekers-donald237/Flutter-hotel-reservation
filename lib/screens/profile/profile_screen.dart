import 'package:flutter/material.dart';
import 'package:flutter_hotel_app_ui/gen/theme.dart';
import '../../models/setting_list_data.dart';
import '../../routes/route_names.dart';
import '../../utils/localfiles.dart';
import '../../widgets/bottom_top_move_animation_view.dart';

class ProfileScreen extends StatefulWidget {
 

  const ProfileScreen({Key? key})
      : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<SettingsListData> userSettingsList = SettingsListData.userSettingsList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(0.0),
                itemCount: userSettingsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      //setting screen view
                      if (index == 5) {
                        NavigationServices(context).gotoSettingsScreen();
    
                        //   setState(() {});
                      }
                      //help center screen view
    
                      if (index == 3) {
                        NavigationServices(context).gotoHeplCenterScreen();
                      }
                      //Chage password  screen view
    
                      if (index == 0) {
                        // NavigationServices(context)
                        //     .gotoChangepasswordScreen();
                      }
                      //Invite friend  screen view
    
                      if (index == 1) {
                        NavigationServices(context).gotoInviteFriend();
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    
                                      userSettingsList[index].titleTxt,
                                    
                                    style:TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Container(
                                  child: Icon(
                                      userSettingsList[index].iconData,
                                      color: kSecondaryColor
                                          .withOpacity(0.7)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
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
    );
  }

  Widget appBar() {
    return InkWell(
      onTap: () {
        NavigationServices(context).gotoEditProfile();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                   "raaj_text",
                    style: new TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "view_edit",
                    style: new TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 24, top: 16, bottom: 16, left: 24),
            child: Container(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                child: Image.asset(Localfiles.profile),
              ),
            ),
          )
        ],
      ),
    );
  }
}
