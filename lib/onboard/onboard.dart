import 'package:find_hotel/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/gen/theme.dart';
import 'package:find_hotel/utils/localfiles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/home_screen.dart';
import 'onboard_model.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  bool onLastPage = false;
  PageController _controller = PageController();
  Color mycolor = kblue;

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    List<OnboardModel> screens = <OnboardModel>[
      OnboardModel(
        img: Localfiles.introduction3,
        text: AppLocalizations.of(context)!.onboard1_screens_title,
        desc: AppLocalizations.of(context)!.onboard1_screens_desc,
      ),
      OnboardModel(
        img: Localfiles.introduction1,
        text: AppLocalizations.of(context)!.onboard2_screens_title,
        desc: AppLocalizations.of(context)!.onboard2_screens_desc,
      ),
      OnboardModel(
        img: Localfiles.introduction2,
        text: AppLocalizations.of(context)!.onboard3_screens_title,
        desc: AppLocalizations.of(context)!.onboard3_screens_desc,
      ),
    ];

    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            for (var i = 0; i < screens.length; i++)
              OnboardWidget(model: screens[i])
          ],
        ),
        Container(
          alignment: Alignment(0, 0.95),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _controller.jumpToPage(2);
                },
                child: Text(
                  AppLocalizations.of(context)!.onboard_skip_message,
                  style: TextStyle(fontSize: 18, color: kblack),
                ),
              ),
              SmoothPageIndicator(controller: _controller, count: 3),
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        _storeOnboardInfo();
                        NavigationServices(context).gotoCurrentUserScreen();
                      },
                      child: Icon(
                        Icons.check,
                        color: kblue,
                        size: 28,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Icon(Icons.arrow_forward_outlined,
                          color: kblue, size: 28),
                    ),
            ],
          ),
        ),
      ],
    ));
  }
}
