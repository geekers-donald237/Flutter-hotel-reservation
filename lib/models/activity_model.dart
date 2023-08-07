import 'package:find_hotel/utils/localfiles.dart';

class Activity {
  final String id;
  final String title;
  final String imagePath;
  final double price;
  final double rating;

  const Activity({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.rating,
  });

  static const List<Activity> activities = [
    Activity(
      id: '1',
      title: 'Cruise and Snorkel the Amalfi Coast',
         imagePath: Localfiles.gallery1,
      price: 39.99,
      rating: 4,
    ),
    Activity(
      id: '2',
      title: 'Hands-on Cooking Class',
         imagePath: Localfiles.gallery2,
      price: 39.99,
      rating: 4,
    ),
    Activity(
      id: '3',
      title: '2-Hours Exclusive Boat Tour',
         imagePath: Localfiles.gallery3,
      price: 39.99,
      rating: 4,
    ),
    Activity(
      id: '4',
      title: 'Kayak along the Beach and the Grotto',
         imagePath: Localfiles.introduction1,
      price: 39.99,
      rating: 4,
    ),
    Activity(
      id: '5',
      title: 'Dine-in a Traditional Farmhouse',
         imagePath: Localfiles.introduction2,
      price: 39.99,
      rating: 4,
    ),
    Activity(
      id: '6',
      title: 'Sunset Tour on the Hills',
         imagePath: Localfiles.introduction3,
      price: 39.99,
      rating: 4,
    ),
  ];
}
