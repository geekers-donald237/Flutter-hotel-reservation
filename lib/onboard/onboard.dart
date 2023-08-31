import 'package:flutter/material.dart';
import 'package:find_hotel/gen/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/auth/login.dart';
import '../utils/Helpers.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  bool onLastPage = false;
  PageController _controller = PageController();
  Color mycolor = kblue;

  @override
  void initState() {
    _storeOnboardInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  PageController pageController = PageController();

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  final List<dynamic> _imageList = [
    'assets/image/illustration-1.png',
    'assets/image/illustration-2.png',
    'assets/image/illustration-3.png',
  ];
  final List<dynamic> _darkimageList = [
    'assets/images/introduction1.png',
    'assets/images/introduction2.png',
    'assets/images/introduction3.png',
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> _titlesList = [
      AppLocalizations.of(context)!.find_the_best_deal,
      AppLocalizations.of(context)!.the_place_you_need_is_here,
      AppLocalizations.of(context)!.a_place_to_visite,
    ];
    final List<String> _subtitlesList = [
      AppLocalizations.of(context)!.the_best_deal_for_your_holidays,
      AppLocalizations.of(context)!.pas_be_deplace,
      AppLocalizations.of(context)!.util_app,
    ];
    return Scaffold(
      backgroundColor: isDarkMode(context) ? const Color(0XFF151618) : null,
      body: Stack(
        children: <Widget>[
          PageView.builder(
            itemBuilder: (context, index) => getPage(
                isDarkMode(context) ? _darkimageList[index] : _imageList[index],
                _titlesList[index],
                _subtitlesList[index],
                context,
                isDarkMode(context)
                    ? (index + 1) == _darkimageList.length
                    : (index + 1) == _imageList.length),
            controller: pageController,
            itemCount:
                isDarkMode(context) ? _darkimageList.length : _imageList.length,
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Visibility(
              visible: _currentIndex + 1 == _imageList.length,
              child: Positioned(
                  right: 13,
                  bottom: 17,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.94,
                      height: MediaQuery.of(context).size.height * 0.1,
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            primary: ksecondryColor),
                        child: Text(
                          AppLocalizations.of(context)!.get_started_,
                          style: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          _storeOnboardInfo();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LogInScreen()),
                              (route) => false);
                        },
                      )))),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 130),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SmoothPageIndicator(
                controller: pageController,
                count: _imageList.length,
                effect: const ScrollingDotsEffect(
                    spacing: 20,
                    activeDotColor: ksecondryColor,
                    dotColor: Color(0XFFFBDBD1),
                    dotWidth: 7,
                    dotHeight: 7,
                    fixedCenter: false),
              ),
            ),
          )),
          Visibility(
            visible: _currentIndex + 1 == _imageList.length,
            child: Positioned(
                left: 15,
                top: 30,
                child: GestureDetector(
                    onTap: () {
                      pageController.previousPage(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.bounceIn);
                    },
                    child: Icon(Icons.chevron_left,
                        size: 40,
                        color:
                            isDarkMode(context) ? Color(0xffFFFFFF) : null))),
          ),
          Visibility(
            visible: _currentIndex + 2 == _imageList.length,
            child: Positioned(
                left: 15,
                top: 30,
                child: GestureDetector(
                    onTap: () {
                      pageController.previousPage(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.bounceIn);
                    },
                    child: Icon(
                      Icons.chevron_left,
                      size: 40,
                      color: isDarkMode(context) ? Color(0xffFFFFFF) : null,
                    ))),
          ),
          Visibility(
              visible: _currentIndex + 1 != _imageList.length,
              child: Positioned(
                  right: 20,
                  top: 40,
                  child: InkWell(
                      onTap: () {
                        _storeOnboardInfo();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LogInScreen()),
                            (route) => false);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.skip_skip_,
                        style: const TextStyle(
                            fontSize: 18,
                            color: ksecondryColor,
                            fontFamily: 'Poppinsm'),
                      )))),
          Visibility(
              visible: _currentIndex + 1 != _imageList.length,
              child: Positioned(
                  right: 13,
                  bottom: 17,
                  child: InkWell(
                      onTap: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.94,
                          height: MediaQuery.of(context).size.height * 0.1,
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                primary: ksecondryColor),
                            child: Text(
                              AppLocalizations.of(context)!.next_next_,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: isDarkMode(context)
                                      ? Color(0xffFFFFFF)
                                      : Color(0XFF333333)),
                            ),
                            onPressed: () {
                              pageController.nextPage(
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.bounceIn);
                            },
                          )))))
        ],
      ),
    );
  }

  Widget getPage(dynamic image, _titlesList, _subtitlesList,
      BuildContext context, bool isLastPage) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Container(
                //  height:  MediaQuery.of(context).size.height*0.55,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                    color: isDarkMode(context)
                        ? Color(0XFF242528)
                        : Color(0XFFFCEEE9),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.elliptical(400, 180),
                        bottomRight: Radius.elliptical(400, 180))),
                child: Container(
                  margin: EdgeInsets.only(right: 40, left: 40, top: 30),

                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.contain)),

                  //  child:
                  //       Image.asset(
                  //           image,
                  //           width: 50.00,
                  //           fit: BoxFit.contain,
                  //         )
                ))),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Text(
          _titlesList,
          textAlign: TextAlign.center,
          style: TextStyle(
              color:
                  isDarkMode(context) ? Color(0xffFFFFFF) : Color(0XFF333333),
              fontFamily: 'Poppinsm',
              fontSize: 20),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 35, left: 35, top: 30),
            child: Text(
              _subtitlesList,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    isDarkMode(context) ? Color(0xffFFFFFF) : Color(0XFF333333),
                fontFamily: 'Poppinsl',
                height: 2,
                letterSpacing: 1.2,
              ),
            )),
        SizedBox(height: MediaQuery.of(context).size.height * 0.25),
      ],
    ));
  }
}
