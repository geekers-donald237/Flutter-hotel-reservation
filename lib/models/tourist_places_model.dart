// ignore_for_file: public_member_api_docs, sort_constructors_first
class TouristPlacesModel {
  final String name;
  final String image;
  TouristPlacesModel({
    required this.name,
    required this.image,
  });
}

List<TouristPlacesModel> touristPlaces = [
  TouristPlacesModel(name: "Mountain", image: "assets/icon/mountain.png"),
  TouristPlacesModel(name: "Beach", image: "assets/icon/beach.png"),
  TouristPlacesModel(name: "Forest", image: "assets/icon/forest.png"),
  TouristPlacesModel(name: "City", image: "assets/icon/city.png"),
  TouristPlacesModel(name: "Desert", image: "assets/icon/desert.png"),
];
