import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:find_hotel/gen/theme.dart';
import '../../models/setting.dart';
import '../../models/setting_list_data.dart';
import '../../routes/route_names.dart';
import '../../utils/localfiles.dart';
import '../../widgets/avatar_card.dart';
import '../../widgets/custom_nav_bar.dart';
import '../../widgets/setting_tile.dart';
import '../../widgets/support_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
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
      bottomNavigationBar: CustomNavBar(index: 3),
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kblack,
        elevation: 2,
        title: Text('Setting'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildViewAndEdit(context),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(
                      settings.length,
                      (index) => SettingTile(setting: settings[index]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(
                      settings2.length,
                      (index) => SettingTile(setting: settings2[index]),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SupportCard()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell BuildViewAndEdit(BuildContext context) {
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
                    "John Doe",
                    style: new TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "View and Edit",
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
