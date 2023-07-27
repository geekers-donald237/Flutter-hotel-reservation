import 'package:flutter_hotel_app_ui/utils/localfiles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HotelModel {
  final String id;
  final String title;
  final String location;
  final String address;
  final String description;
  final String thumbnailPath;
  final List<String> imagePaths;
  final int totalReview;
  final double ratingScore;
  final double price;
  final LatLng coordinate;

  const HotelModel({
    required this.id,
    required this.title,
    required this.location,
    required this.address,
    required this.description,
    required this.thumbnailPath,
    required this.imagePaths,
    required this.price,
    required this.coordinate,
    this.ratingScore = 0,
    this.totalReview = 0,
  });

  static List<HotelModel> sampleHotels = const [
    HotelModel(
      id: '1',
      thumbnailPath: Localfiles.thumbnail1,
      title: 'D`Omah Hotel Yogya',
      location: 'Bantul Regency, Yogyakarta',
      address: 'Jl. Parangtritis km 8.5, Yogyakarta 55186',
      description:
          'We are only a 10-minute drive from the Water Castle (Tamansari) and Yogyakarta Palace. An airport shuttle is provided for a surcharge (available 24 hours).',
      ratingScore: 4.25,
      coordinate: LatLng(-7.8712168283326625, 110.353484068852),
      price: 458,
      imagePaths: [
       Localfiles.gallery1,
         Localfiles.gallery2,
         Localfiles.gallery3,
      ],
      totalReview: 134,
    ),
    HotelModel(
      id: '2',
      thumbnailPath: Localfiles.thumbnail2,
      title: 'Greenhost Boutique Hotel',
      location: 'Bantul Regency, Yogyakarta',
      address: 'Jl. Parangtritis km 8.5, Yogyakarta 55186',
      description:
          'We are only a 10-minute drive from the Water Castle (Tamansari) and Yogyakarta Palace. An airport shuttle is provided for a surcharge (available 24 hours).',
      ratingScore: 3.6,
      coordinate: LatLng(-7.8188302371260265, 110.36928495262913),
      price: 338,
      imagePaths: [
       Localfiles.gallery1,
         Localfiles.gallery2,
         Localfiles.gallery3,
      ],
      totalReview: 432,
    ),
    HotelModel(
      id: '3',
      thumbnailPath: Localfiles.thumbnail1,
      title: 'Candi Tirta Raharjo',
      location: 'Bantul Regency, Yogyakarta',
      address: 'Jl. Parangtritis km 8.5, Yogyakarta 55186',
      description:
          'We are only a 10-minute drive from the Water Castle (Tamansari) and Yogyakarta Palace. An airport shuttle is provided for a surcharge (available 24 hours).',
      ratingScore: 2.6,
      coordinate: LatLng(-7.842320836894338, 110.33722565674677),
      price: 698,
      imagePaths: [
       Localfiles.gallery1,
         Localfiles.gallery2,
         Localfiles.gallery3,
      ],
      totalReview: 99,
    ),
    HotelModel(
      id: '4',
      thumbnailPath: Localfiles.thumbnail2,
      title: 'Alana Hotel',
      location: 'Bantul Regency, Yogyakarta',
      address: 'Jl. Parangtritis km 8.5, Yogyakarta 55186',
      description:
          'We are only a 10-minute drive from the Water Castle (Tamansari) and Yogyakarta Palace. An airport shuttle is provided for a surcharge (available 24 hours).',
      ratingScore: 10,
      coordinate: LatLng(-7.8147871933139434, 110.36921653947174),
      price: 123,
      imagePaths: [
       Localfiles.gallery1,
         Localfiles.gallery2,
         Localfiles.gallery3,
      ],
      totalReview: 5,
    ),
  ];
}
