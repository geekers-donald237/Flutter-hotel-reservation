import 'package:find_hotel/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/gen/theme.dart';
import 'package:find_hotel/utils/localfiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home_screen.dart';
import 'onboard_model.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  Color mycolor = kblue;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: Localfiles.introduction3,
      text: "Find The Best Deal",
      desc: "Lorem Ipsum dolor si consctur",
      bg: Colors.white,
      button: Color(0xFF4756DF),
    ),
    OnboardModel(
      img: Localfiles.introduction1,
      text: "Dapatkan Kemudahan Akses Kapanpun dan Dimanapun",
      desc:
          "Tidak peduli dimanapun kamu, semua kursus yang telah kamu ikuti bias kamu akses sepenuhnya",
      bg: Color(0xFF4756DF),
      button: Colors.white,
    ),
    OnboardModel(
      img: Localfiles.introduction2,
      text: "Gunakan Fitur Kolaborasi Untuk Pengalaman Lebih",
      desc:
          "Tersedia fitur Kolaborasi dengan tujuan untuk mengasah skill lebih dalam karena bias belajar bersama",
      bg: Colors.white,
      button: Color(0xFF4756DF),
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex % 2 == 0 ? kwhite : kblue,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            // physics: NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
                if (currentIndex % 2 == 0) {
                  setState(() {
                    mycolor = kblue;
                  });
                } else {
                  setState(() {
                    mycolor = kwhite;
                  });
                }
              });
            },
            itemBuilder: (_, index) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(screens[index].img),
                    Text(
                      screens[index].text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: index % 2 == 0 ? kblack : kwhite,
                      ),
                    ),
                    Text(
                      screens[index].desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Montserrat',
                        color: index % 2 == 0 ? kblack : kwhite,
                      ),
                    ),
                    Container(
                      alignment: Alignment(0, 0.75),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              _storeOnboardInfo();
                              NavigationServices(context).gotohomeScreen();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 15.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index % 2 != 0 ? kwhite : kblue,
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.check,
                                    color: index % 2 != 0 ? kblue : kwhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 10.0,
                            child: ListView.builder(
                              itemCount: screens.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        width: currentIndex == index ? 25 : 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: currentIndex == index
                                              ? kPrimaryColor
                                              : kSecondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ]);
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              print(index);
                              if (index == screens.length - 1) {
                                await _storeOnboardInfo();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              }

                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.bounceIn,
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 15.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index % 2 != 0 ? kwhite : kblue,
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: index % 2 != 0 ? kblue : kwhite,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
