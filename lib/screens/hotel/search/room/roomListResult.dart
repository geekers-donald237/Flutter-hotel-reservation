import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:find_hotel/screens/image_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../api/encrypt.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/theme.dart';
import '../../../../models/DestinationModel.dart';
import '../../../../models/HotelModel.dart';
import '../../../../../../../providers/utils_provider.dart';
import '../../../../models/room_Model.dart';
import '../../../../urls/all_url.dart';
import '../../../../utils/helper.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_rating.dart';
import '../../../../widgets/place_widget.dart';

class RoomListResult extends StatefulWidget {
  const RoomListResult({
    Key? key,
    required this.hotel,
    required this.destination_1
  }) : super(key: key);

  final HotelModels hotel;
  final DestinationModel destination_1;

  @override
  State<RoomListResult> createState() => _RoomListResultState();
}

class _RoomListResultState extends State<RoomListResult> with TickerProviderStateMixin{
  bool isFavorite = false;
  bool isLoading = true;
  List<PlaceWidget> room = [];
  int total = 0;
  AnimationController? animationController;

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    getDetailListRoom();
    super.initState();
  }

  getDetailListRoom() async {
    try {
      var url = Uri.parse(Urls.hotel);
      final response = await http.post(url, body: {
        "id": encrypt(widget.hotel.id.toString()),
        "action": encrypt('get_hotel_details'),
      });
      // if (kDebugMode) {
      //   print(response.body);
      // }

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          isLoading = false;
        });


        int count = data['rooms'].length;
        total = count;
        // if (kDebugMode) {
        //   print(data['rooms']);
        // }
        for (var item in data['rooms']) {
          final Animation<double> animation = Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(parent: animationController!, curve: Interval( (1 / count) * index, 1, curve: Curves.fastOutSlowIn ))
          );


          PlaceWidget widgets = PlaceWidget(
            animation: animation,
            animationController: animationController,
            item: RoomModel.fromJson(item),
            hotel: widget.hotel,
            destination_1: widget.destination_1,

          );
          room.add(widgets);
          widgets.animationController?.forward();

          setState(() {
            index++;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } on SocketException {
      setState(() {
        isLoading = false;
      });
      EasyLoading.showInfo(AppLocalizations.of(context)!.verified_internet,
          duration: const Duration(seconds: 4));
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.showInfo(AppLocalizations.of(context)!.an_error_occur,
          duration: const Duration(seconds: 4));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child:
            NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool nnerBoxIsScrolled) {
                return [


                  SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: FilterTabHeader(
                          _buildFilterUI()
                      )
                  )
                ];
              },
              body: RefreshIndicator(
                  onRefresh: () {
                    room.clear();
                    return getDetailListRoom();
                  },
                  child: _buildContent()),
            ),
          )

        ],
      )
    );
  }


  Widget _buildContent() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: room.length,
          padding: EdgeInsets.only(top: 8),
          itemBuilder: ((context, index) {
            return room[index];
          })),
    );
  }



  Widget _buildFilterUI() {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
          child: Row(
            children: [
              Expanded(child:
              Container(
                padding: EdgeInsets.all(8),
                child: Text("$total Places found",
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 16
                  ),
                ),

              )
              ),

              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Text("Filter", style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16,)),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.sort, color: Colors.grey,),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class FilterTabHeader extends SliverPersistentHeaderDelegate {

  final Widget filterUI;
  FilterTabHeader(this.filterUI);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    return filterUI;
  }

  @override
  double get maxExtent => 55;

  @override
  double get minExtent => 55;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }


}
