import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../gen/assets.gen.dart';
import '../gen/theme.dart';
import '../models/hotel_model.dart';
import '../providers/current_location.dart';
import '../utils/helper.dart';
import '../widgets/app_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_icon_container.dart';
import '../widgets/custom_rating.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final HotelModel hotel;

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isSelected = false;

    Color color = Colors.black;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kblue,
        foregroundColor: kblack,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
              size: 30,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 8.0, right: 12),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Ionicons.share_social_outline, size: 30),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.only(top: size.height * 0.1),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _HotelTitleSection(hotel: widget.hotel),
                    const SizedBox(height: 16),
                    const _FacilitiesSection(),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 0.5, // Ajout d'une élévation au Card
                      margin: EdgeInsets.all(2), // Marge autour du Card
                      child: Padding(
                        padding: EdgeInsets.all(
                            16), // Espacement à l'intérieur du Card
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Arrival Date:',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'August 25, 2023',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Departure Date:',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'August 30, 2023',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nombre d\'hébergement et de personnes',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '22',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _GallerySection(imagePaths: widget.hotel.imagePaths),
              Padding(
                padding: const EdgeInsets.all(20),
                child: _LocationSection(
                  address: widget.hotel.address,
                  coordinate: widget.hotel.coordinate,
                  description: widget.hotel.description,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _ReserveBar(price: widget.hotel.price),
    );
  }
}

class _HotelTitleSection extends StatelessWidget {
  const _HotelTitleSection({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final HotelModel hotel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.large(
              hotel.title,
              textAlign: TextAlign.left,
              maxLine: 2,
              textOverflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 10),
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue, // Couleur du carré
                borderRadius: BorderRadius.circular(5),
              ),
              child: AppText.small(
                hotel.ratingScore.toString(), // Note de l'hôtel
                color: Colors.white, // Couleur du texte à l'intérieur du carré
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Assets.icon.location.svg(color: kDarkGreyColor, height: 15),
            const SizedBox(width: 10),
            AppText.small(hotel.location),
          ],
        ),
        const SizedBox(height: 10),
        CustomRating(
          ratingScore: hotel.ratingScore,
          showReviews: true,
          totalReviewer: hotel.totalReview,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _FacilitiesSection extends StatelessWidget {
  const _FacilitiesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium('Facilities', fontWeight: FontWeight.bold),
        const SizedBox(height: 10),
        Table(
          columnWidths: const {0: FlexColumnWidth(), 1: FlexColumnWidth()},
          children: [
            TableRow(
              children: [
                _buildIconWithLabel(
                  Assets.icon.amenities.hotel.svg(),
                  '4-Star Hotel',
                ),
                _buildIconWithLabel(
                  Assets.icon.amenities.roomService.svg(),
                  'Room Service',
                ),
              ],
            ),
            TableRow(
              children: [
                _buildIconWithLabel(
                  Assets.icon.amenities.wifi.svg(),
                  'Free Wi-Fi',
                ),
                _buildIconWithLabel(
                  Assets.icon.amenities.ac.svg(),
                  'Air Conditioner',
                ),
              ],
            ),
            TableRow(
              children: [
                _buildIconWithLabel(
                  Assets.icon.amenities.transport.svg(),
                  'Airport Pickup',
                ),
                _buildIconWithLabel(
                  Assets.icon.amenities.swimmingPool.svg(),
                  'Swimming Pool',
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () =>{},
            child: AppText.medium('Show more',
                textDecoration: TextDecoration.underline))
      ],
    );
  }

  Padding _buildIconWithLabel(
    SvgPicture icon,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 10),
          AppText.medium(label, fontWeight: FontWeight.normal),
        ],
      ),
    );
  }
}

class _GallerySection extends StatelessWidget {
  const _GallerySection({
    Key? key,
    required this.imagePaths,
  }) : super(key: key);

  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AppText.medium('Gallery', fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 150,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10),
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              final imagePath = imagePaths[index];
              return AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LocationSection extends ConsumerWidget {
  const _LocationSection({
    Key? key,
    required this.address,
    required this.coordinate,
    required this.description,
  }) : super(key: key);

  final String address;
  final LatLng coordinate;
  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double longitude = ref.watch(LongitudeProvider);
    double latitude = ref.watch(LattitudeProvider);

    final double distance = getDistanceFromLatLonInKm(
      latitude,
      longitude,
      coordinate.latitude,
      coordinate.longitude,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium('Location', fontWeight: FontWeight.bold),
        const SizedBox(height: 10),
        AppText.medium('situe a une distance de $distance km de vous ',
            fontWeight: FontWeight.normal),
        const SizedBox(height: 10),
        FutureBuilder<BitmapDescriptor?>(
          future: _convertToMarkerBitmap(),
          builder: (context, snapshot) {
            final bitmapData = snapshot.data;
            if (bitmapData == null) {
              return const SizedBox.shrink();
            } else {
              return SizedBox(
                height: 200,
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  initialCameraPosition:
                      CameraPosition(target: coordinate, zoom: 15),
                  markers: {
                    Marker(
                      markerId: MarkerId(address),
                      position: coordinate,
                      icon: bitmapData,
                    ),
                  },
                ),
              );
            }
          },
        ),
        const SizedBox(height: 10),
        AppText.medium(description, fontWeight: FontWeight.normal),
        const SizedBox(height: 10),
        AppText.medium('Show more', textDecoration: TextDecoration.underline)
      ],
    );
  }

  Future<BitmapDescriptor?> _convertToMarkerBitmap() async {
    final data = await rootBundle.load(Assets.icon.pinPng.path);
    final uint8List = data.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(uint8List);
  }
}

class _ReserveBar extends StatelessWidget {
  const _ReserveBar({
    Key? key,
    required this.price,
  }) : super(key: key);

  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(20.0).copyWith(top: 10.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.medium('Start from', fontWeight: FontWeight.normal),
              RichText(
                text: TextSpan(
                  children: [
                    AppTextSpan.large('\$$price'),
                    AppTextSpan.medium(' /night'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 150,
            child: CustomButton(
              buttonText: 'Reserve',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
