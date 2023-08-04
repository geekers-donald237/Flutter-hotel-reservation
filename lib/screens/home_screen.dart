import 'package:find_hotel/providers/all_accomodation.dart';
import 'package:find_hotel/providers/all_adults_provider.dart';
import 'package:find_hotel/providers/all_enfants_provider.dart';
import 'package:find_hotel/routes/route_names.dart';
import 'package:find_hotel/widgets/date_textfield.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../gen/assets.gen.dart';
import '../gen/theme.dart';
import '../models/hotel_model.dart';
import '../providers/all_hotels_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_icon_container.dart';
import '../widgets/custom_nav_bar.dart';
import '../widgets/custom_number_input.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/hotel_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      bottomNavigationBar: CustomNavBar(index: 0),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(top: size.height * 0.25),
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _HeaderSection(),
                    _SearchCard(),
                    SizedBox(height: 20),
                    _NearbyHotelSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Find Hotel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            CustomIconButton(
              icon: Assets.icon.notification.svg(height: 25),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
        )
      ],
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
                color: ColorName.blue,
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationTextController = TextEditingController();
    final dateControllerFrom = TextEditingController();
    accomodation = ref.watch(allAccomodationProvider);
    adults = ref.watch(allAdultsProvider);
    children = ref.watch(allChildrenProvider);

    locationTextController;
    dateControllerTo.text = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ColorName.lightGrey.withAlpha(50),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Assets.icon.location.svg(color: ColorName.blue),
              const SizedBox(width: 16),
              InkWell(
                onTap: () {
                  NavigationServices(context).gotoSearchScreen();
                },
                child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: kblue), // Bordure uniquement en bas
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose Your Destination",
                          style: TextStyle(color: kblue),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Row(
            children: [
              Assets.icon.calendar.svg(color: ColorName.blue),
              const SizedBox(width: 16),
              DateField(dateController: dateControllerTo, label: 'From'),
              DateField(dateController: dateControllerFrom, label: 'To'),
            ],
          ),
          Row(
            children: [
              Assets.icon.profile.svg(color: ColorName.blue),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.all(4.0),
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
            ],
          ),
          const SizedBox(height: 16),
          CustomButton(
            buttonText: 'Search',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
