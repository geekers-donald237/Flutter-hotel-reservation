import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:find_hotel/screens/hotel/search/Index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../gen/theme.dart';
import '../../../models/DestinationModel.dart';
import '../../../routes/route_names.dart';
// import '../../../widgets/recommended_places.dart';
import 'activity_screen.dart';
import '../../../models/hotel_model.dart';
import '../../../providers/all_hotels_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_number_input.dart';
import '../../../widgets/hotel_card.dart';

import '../../../../providers/utils_provider.dart';

import 'package:find_hotel/urls/all_url.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:ionicons/ionicons.dart';

class StayScreen extends StatefulWidget {
  const StayScreen({
    super.key,
  });


  @override
  State<StayScreen> createState() => _StayScreenState();
}

class _StayScreenState extends State<StayScreen> {
 // bool isLoading = true; // Variable pour suivre l'état de chargement

  @override
  void initState() {
    // TODO: implement initState
    EasyLoading.dismiss();
    super.initState();

  }

  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final double height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
              //physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(14),
              children: [
                SizedBox(
                  height: height * 0.01,
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
                        child:
                            Text(AppLocalizations.of(context)!.view_all_hotel))
                  ],
                ),
                const SizedBox(height: 10),
                // const RecommendedPlaces(),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.more_option_hotel,
                      textAlign: TextAlign.start,
                      semanticsLabel:
                          AppLocalizations.of(context)!.more_option_hotel,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                ActivitiesScreen(),
              ],
            ),
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
}




class _SearchCard extends ConsumerWidget {
  bool isSetPosition = false, isSetDate = false;
  TextEditingController dateControllerTo = TextEditingController();
  late int accomodation;
  late int adults;
  late int children;

  TextEditingController destinationController = TextEditingController();

  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime.now(),
    DateTime(2023, 12, 13),
  ];
  String dateTravel = '';

  void _openPassengerModal(BuildContext context, WidgetRef ref) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.modal_info_number,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(),
                    Row(
                      children: [
                        Expanded(
                          child:
                              Text(AppLocalizations.of(context)!.hbgt_number),
                        ),
                        CustomNumberInput(
                          value: accomodation,
                          onDecrease: () {
                            setState(() {
                              if (accomodation <= 1) {
                              } else {
                                accomodation--;
                              }
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
                              if (adults <= 1) {
                              } else {
                                adults--;
                              }
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
                          child:
                              Text(AppLocalizations.of(context)!.child_number),
                        ),
                        CustomNumberInput(
                          value: children,
                          onDecrease: () {
                            setState(() {
                              if (children == 0) {
                              } else {
                                children--;
                              }
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
                    const SizedBox(height: 20),
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
              ),
            );
          },
        );
      },
    );
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

  _buildCalendarDialogButton(BuildContext context, WidgetRef ref) {
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
            InkWell(
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
                    dateTravel =
                        formatDateToDay(_dialogCalendarPickerValue[0]!) +
                            "-" +
                            formatDateToDay(_dialogCalendarPickerValue[1]!);

                    isSetDate = true;
                  });

                  setState(() {
                    dateTravel;
                  });

                  ref
                      .read(StringDateProvider.notifier)
                      .update((state) => dateTravel);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.calendar_month),
                  ),
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 16.0),
                        child: dateTravel != ''
                            ? Text(
                                dateTravel,
                              )
                            : Text(
                                AppLocalizations.of(context)!.duree_sejour,
                                textAlign: TextAlign.start,
                              ),
                      ))
                ],
              ),
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

  search(String destination,int accomodation,String datetravel,int adult,int children){

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    accomodation = ref.watch(allAccomodationProvider);
    adults = ref.watch(allAdultsProvider);
    children = ref.watch(allChildrenProvider);
    dateTravel = ref.watch(StringDateProvider);
    String destination = '';

    if(ref.watch(LocationCurrentProvider) == ''){
      destination = AppLocalizations.of(context)!.choose_loca;
    }else{
      destination = ref.watch(LocationCurrentProvider);
    }

    return Container(
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Icon(Ionicons.search),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    NavigationServices(context).gototestScreen();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      destination,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 4, // Épaisseur du Divider
            color: yellow,
          ),
          // Deuxième Row
          _buildCalendarDialogButton(context, ref),
          const Divider(
            thickness: 4,
            color: yellow,
          ),
          // Troisième Row
          InkWell(
            onTap: () {
              _openPassengerModal(context, ref);
            },
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Icon(
                    Ionicons.person_outline,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$accomodation 🏠.",
                      ),
                      Text(" $adults ${AppLocalizations.of(context)!.adults_}."),
                      Text(" $children ${AppLocalizations.of(context)!.children_}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 4,
            color: yellow,
          ),
          CustomButton(
            buttonText: AppLocalizations.of(context)!.search_btn,
            onPressed: () {
              EasyLoading.show(status: AppLocalizations.of(context)!.loading);
              if (destination == AppLocalizations.of(context)!.choose_loca ||
                  dateTravel == '') {
                EasyLoading.showError(
                    duration: const Duration(milliseconds: 1500),
                    AppLocalizations.of(context)!.all_fields_destination);
              } else {
                EasyLoading.dismiss();
                search(destination,accomodation,dateTravel,adults,children);
                DestinationModel destination_1 = DestinationModel(
                  destination: destination,
                  accomodation: accomodation,
                  dateTravel: dateTravel,
                  adults: adults,
                  children: children,
                );
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SearchIndex(destination_1: destination_1,)),
                        (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
