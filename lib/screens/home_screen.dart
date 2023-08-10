import 'package:find_hotel/providers/all_accomodation.dart';
import 'package:find_hotel/providers/all_adults_provider.dart';
import 'package:find_hotel/providers/all_enfants_provider.dart';
import 'package:find_hotel/providers/current_location.dart';
import 'package:find_hotel/routes/route_names.dart';
import 'package:find_hotel/screens/location_page.dart';
import 'package:find_hotel/urls/all_url.dart';
import 'package:find_hotel/utils/localfiles.dart';
import 'package:find_hotel/widgets/date_textfield.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:ionicons/ionicons.dart';

import '../gen/assets.gen.dart';
import '../gen/theme.dart';
import '../models/hotel_model.dart';
import '../providers/all_hotels_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_icon_container.dart';
import '../widgets/custom_nav_bar.dart';
import '../widgets/custom_number_input.dart';
import '../widgets/hotel_card.dart';
import '../widgets/recommended_places.dart';
import 'activity_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: BuildAppbar(context),
        drawer: CustomDrawer(),
        bottomNavigationBar: CustomNavBar(index: 0),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(14),
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            const LocationPage(),

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
                  "Recommendation",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(onPressed: () {}, child: const Text("View All"))
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
                  "Plus d'options pour vous",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),

            ActivitiesScreen(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Nearby From You",
            //       style: Theme.of(context).textTheme.titleLarge,
            //     ),
            //     TextButton(onPressed: () {}, child: const Text("View All"))
            //   ],
            // ),
            // const SizedBox(height: 10),
            // const NearbyPlaces(),
          ],
        ));
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
            Text(name, style: TextStyle(fontSize: 14, color: Colors.white)),
            SizedBox(
              height: 10,
            ),
            Text('$name$surname@gmail.com',
                style: TextStyle(fontSize: 14, color: Colors.white))
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

  AppBar BuildAppbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      shape: Border(bottom: BorderSide(color: kblack, width: 2)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rental",
            style: TextStyle(color: kblue),
          ),
          Text(
            "Find The Best Deal for Your holidays",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
      actions: const [
        CustomIconButton(
          icon: Icon(
            Ionicons.search_outline,
            color: kblue,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 12),
          child: CustomIconButton(
            icon: Badge(
                backgroundColor: accent,
                child: Icon(
                  Ionicons.notifications_outline,
                  color: kblue,
                )),
          ),
        ),
      ],
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
              color: Colors.white,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 20, color: Colors.white),
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
                        child: Text("Nombre d'hébergement:"),
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
                        child: Text("Nombre d'adultes:"),
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
                        child: Text("Nombre d'enfant:"),
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
                    child: Text("Valider"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _openDestinationDialog(BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isButtonDisabled = true; // Par défaut, le bouton est désactivé

        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Saisissez votre destination'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: destinationController,
                    onChanged: (value) {
                      setState(() {
                        if (value.length >= 3) {
                          isButtonDisabled = false;
                        } else {
                          isButtonDisabled = true;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Eg: Yaounde,obili',
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // destination = "Ma Position Actuelle";
                          // ref
                          //     .read(LocationCurrentProvider.notifier)
                          //     .update((state) => destination);
                          // Navigator.of(context).pop();
                        },
                        child: Text('Utiliser ma position'),
                      ),
                      ElevatedButton(
                        onPressed: isButtonDisabled
                            ? null // Désactiver le bouton si isButtonDisabled est vrai
                            : () {
                                destination = destinationController.text;
                                ref
                                    .read(LocationCurrentProvider.notifier)
                                    .update((state) => destination);
                                Navigator.of(context).pop();
                              },
                        child: Text('Valider'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationTextController = TextEditingController();
    final dateControllerFrom = TextEditingController();
    accomodation = ref.watch(allAccomodationProvider);
    adults = ref.watch(allAdultsProvider);
    children = ref.watch(allChildrenProvider);
    destination = ref.watch(LocationCurrentProvider);

    locationTextController;
    dateControllerTo.text = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Assets.icon.location
                    .svg(color: kblue), // Remplacez kBlue par votre couleur
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _openDestinationDialog(context, ref);
                    },
                    child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey), // Bordure autour du Row
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(destination),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Assets.icon.calendar.svg(color: kblue),
                const SizedBox(width: 16),
                DateField(dateController: dateControllerTo, label: 'From'),
                DateField(dateController: dateControllerFrom, label: 'To'),
              ],
            ),
            Row(
              children: [
                Assets.icon.profile.svg(color: kblue),
                const SizedBox(width: 5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _openPassengerModal(context, ref);
                      },
                      child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey), // Bordure autour du Row
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("$accomodation Hébgts."),
                              Text(" $adults Adultes."),
                              Text(" $children Enfants"),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              buttonText: 'Search',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
