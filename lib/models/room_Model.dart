class RoomModel {
  int? id;
  String? name;
  int? room_capacity;
  int? surface_area;
  int? price;
  String? imagePath;

  RoomModel(
      {this.id,
        this.name,
        this.room_capacity,
        this.surface_area,
        this.price,
        this.imagePath,
      });

  factory RoomModel.fromJson(Map json) {
    return RoomModel(
      id : json['id'],
      name : json['name'],
      room_capacity : json['room_capacity'],
      surface_area : json['surface_area'],
      price : json['price'],
      imagePath : json['imagePath'],
    );
  }
}
