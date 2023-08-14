import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../gen/theme.dart';
import '../../models/hotel_model.dart';
import '../../providers/all_hotels_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_number_input.dart';
import '../../widgets/hotel_card.dart';
import '../../widgets/nearby_places.dart';
import '../../widgets/recommended_places.dart';
import '../activity_screen.dart';

import 'package:find_hotel/providers/all_accomodation.dart';
import 'package:find_hotel/providers/all_adults_provider.dart';
import 'package:find_hotel/providers/all_enfants_provider.dart';
import 'package:find_hotel/providers/current_location.dart';
import 'package:find_hotel/routes/route_names.dart';
import 'package:find_hotel/urls/all_url.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ionicons/ionicons.dart';

class StayScreen extends StatefulWidget {
  const StayScreen({super.key});

  @override
  State<StayScreen> createState() => _StayScreenState();
}

class _StayScreenState extends State<StayScreen> {
  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // L'utilisateur ne peut pas annuler en cliquant à l'extérieur
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            // Supprimer les bords
            borderRadius: BorderRadius.circular(0),
          ),
          title: Text(AppLocalizations.of(context)!.exit_title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context)!.exit_text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.exit_response_non),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.exit_response_oui),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        _showExitConfirmationDialog(context);
        return false;
      },
      child: Scaffold(
          body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(14),
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          _SearchCard(),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.recommendation,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(AppLocalizations.of(context)!.view_all_hotel))
            ],
          ),
          const SizedBox(height: 10),
          const RecommendedPlaces(),
          const SizedBox(height: 10),
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.more_option_hotel,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),

          // ActivitiesScreen(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nearby From You",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(onPressed: () {}, child: const Text("View All"))
            ],
          ),
          const SizedBox(height: 10),
          const NearbyPlaces(),
        ],
      )),
    );
  }

  Widget headerWidget() {
    const name = "John";
    const surname = "Doe";
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(Urls.userAvatar + name + "+" + surname),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(name, style: TextStyle(fontSize: 14, color: kDarkGreyColor)),
            SizedBox(
              height: 10,
            ),
            Text('$name$surname@gmail.com',
                style: TextStyle(fontSize: 14, color: kDarkGreyColor))
          ],
        )
      ],
    );
  }

  Drawer CustomDrawer() {
    return Drawer(
      child: Material(
        color: Colors.white,
        textStyle: TextStyle(color: kblack),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                headerWidget(),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: AppLocalizations.of(context)!.drawer_person,
                    icon: Ionicons.person,
                    onPressed: () {
                      NavigationServices(context).gotoEditProfile();
                    }),
                const SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: AppLocalizations.of(context)!.drawer_account,
                    icon: Icons.account_box_rounded,
                    onPressed: () {}),
                const SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: AppLocalizations.of(context)!.drawer_bug_report,
                    icon: Ionicons.bug_outline,
                    onPressed: () {}),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: 1,
                  height: 10,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: AppLocalizations.of(context)!.drawer_propos,
                    icon: Icons.info_outline,
                    onPressed: () {}),
                const SizedBox(
                  height: 15,
                ),
                DrawerItem(
                    name: AppLocalizations.of(context)!.drawer_logout,
                    icon: Icons.logout,
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: kblack,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 20, color: kgrey),
            )
          ],
        ),
      ),
    );
  }
}

class _NearbyHotelSection extends ConsumerWidget {
  const _NearbyHotelSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hotels = ref.watch(allHotelsProvider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Nearby hotels',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              'See all',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: kblue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        hotels.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error: $err'),
          data: (hotels) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: hotels.length,
              itemBuilder: (BuildContext context, int index) {
                HotelModel hotel = hotels[index];
                return HotelCard(hotel: hotel);
              },
            );
          },
        ),
      ],
    );
  }
}

class _SearchCard extends ConsumerWidget {
  TextEditingController dateControllerTo = TextEditingController();
  int accomodation = 0;
  int adults = 0;
  int children = 0;
  TextEditingController destinationController = TextEditingController();
  String destination = '';
  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime(2023, 2, 10),
    DateTime(2023, 5, 13),
  ];

  String startDate = 'yyyy - mm';

  String endDate = 'dd';

  void _openPassengerModal(BuildContext context, WidgetRef ref) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.hbgt_number),
                      ),
                      CustomNumberInput(
                        value: accomodation,
                        onDecrease: () {
                          setState(() {
                            accomodation--;
                          });
                        },
                        onIncrease: () {
                          setState(() {
                            accomodation++;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child:
                            Text(AppLocalizations.of(context)!.adults_number),
                      ),
                      CustomNumberInput(
                        value: adults,
                        onDecrease: () {
                          setState(() {
                            adults--;
                          });
                        },
                        onIncrease: () {
                          setState(() {
                            adults++;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.child_number),
                      ),
                      CustomNumberInput(
                        value: children,
                        onDecrease: () {
                          setState(() {
                            children--;
                          });
                        },
                        onIncrease: () {
                          setState(() {
                            children++;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(allAccomodationProvider.notifier)
                          .update((state) => accomodation);
                      ref
                          .read(allAdultsProvider.notifier)
                          .update((state) => adults);
                      ref
                          .read(allChildrenProvider.notifier)
                          .update((state) => children);
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.valid_btn),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<String> getDestinationInfo(WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    destination = prefs.getString('destination')!;
    return destination;
  }

  void callinfo(WidgetRef ref) async {
    destination = await getDestinationInfo(ref);
    ref.read(LocationCurrentProvider.notifier).update((state) => destination);
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  _buildCalendarDialogButton(BuildContext context) {
    const dayTextStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w700);

    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: kblue,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
    );
    return StatefulBuilder(builder: (BuildContext context, setState) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.calendar_month),
                ),
                Expanded(
                    child: InkWell(
                  onTap: () async {
                    final values = await showCalendarDatePicker2Dialog(
                      context: context,
                      config: config,
                      dialogSize: const Size(325, 400),
                      borderRadius: BorderRadius.circular(15),
                      value: _dialogCalendarPickerValue,
                      dialogBackgroundColor: Colors.white,
                    );
                    if (values != null) {
                      // ignore: avoid_print
                      print(_getValueText(
                        config.calendarType,
                        values,
                      ));
                      setState(() {
                        _dialogCalendarPickerValue = values;
                      });
                      setState(() {
                        startDate =
                            formatDateToDay(_dialogCalendarPickerValue[0]!);
                        endDate =
                            formatDateToDay(_dialogCalendarPickerValue[1]!);
                      });

                      setState(() {
                        startDate;
                        endDate;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      '${startDate} - ${endDate}',
                    ),
                  ),
                ))
              ],
            ),
          ],
        ),
      );
    });
  }

  String formatDateToDay(DateTime dateTime) {
    final days = ['lun.', 'mar.', 'merc.', 'jeu.', 'ven.', 'sam.', 'dim.'];
    final months = [
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre'
    ];

    String dayOfWeek = days[dateTime.weekday - 1];
    int day = dateTime.day;
    String month = months[dateTime.month - 1];

    return '$dayOfWeek $day $month';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    accomodation = ref.watch(allAccomodationProvider);
    adults = ref.watch(allAdultsProvider);
    children = ref.watch(allChildrenProvider);
    destination = ref.watch(LocationCurrentProvider);
    callinfo(ref);

    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Première Row
          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Ionicons.search),
                ),
                // const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // _openDestinationDialog(context, ref);
                      NavigationServices(context).gototestScreen();
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text(destination),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 4, // Épaisseur du Divider
            color: yellow,
          ),
          // Deuxième Row
          _buildCalendarDialogButton(context),
          Divider(
            thickness: 4,
            color: yellow,
          ),
          // Troisième Row
          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.person_outlined,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    _openPassengerModal(context, ref);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$accomodation Hébgts."),
                        Text(" $adults Adultes."),
                        Text(" $children Enfants"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 4,
            color: yellow,
          ),
          CustomButton(
            buttonText: AppLocalizations.of(context)!.search_btn,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
