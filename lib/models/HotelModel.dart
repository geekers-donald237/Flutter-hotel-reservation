class HotelModels {
  int? id;
  String? name;
  double? latitude;
  double? longitude;
  int? nbStars;
  String? nameOnBill;
  String? breakfastServed;
  String? breakfastInBudget;
  int? breakfastPerPerson;
  String? haveParking;
  String? freeParking;
  int? parkingPricePerHr;
  String? parkingLocation;
  String? parkingPrivacy;
  String? hostlanguage;
  String? petsAutorize;
  String? partyAutorize;
  String? smokeAutorize;
  String? kidsAutorize;
  int? idRepresentative;
  String? idTown;
  String? hotelDescription;
  String? hostDescription;
  String? streetDescription;
  String? address;
  int? minPrice;
  int? maxPrice;
  String? contactPhone;
  String? contactEmail;
  String? imagePath;

  HotelModels(
      {this.id,
        this.name,
        this.latitude,
        this.longitude,
        this.nbStars,
        this.nameOnBill,
        this.breakfastServed,
        this.breakfastInBudget,
        this.breakfastPerPerson,
        this.haveParking,
        this.freeParking,
        this.parkingPricePerHr,
        this.parkingLocation,
        this.parkingPrivacy,
        this.hostlanguage,
        this.petsAutorize,
        this.partyAutorize,
        this.smokeAutorize,
        this.kidsAutorize,
        this.idRepresentative,
        this.idTown,
        this.hotelDescription,
        this.hostDescription,
        this.streetDescription,
        this.address,
        this.minPrice,
        this.maxPrice,
        this.contactPhone,
        this.contactEmail,
        this.imagePath});

  factory HotelModels.fromJson(Map json) {
    return HotelModels(
        id : json['id'],
        name : json['name'],
        latitude : json['latitude'],
        longitude : json['longitude'],
        nbStars : json['nb_stars'],
        nameOnBill : json['name_on_bill'],
        breakfastServed : json['breakfast_served'],
        breakfastInBudget : json['breakfast_in_budget'],
        breakfastPerPerson : json['breakfast_per_person'],
        haveParking : json['have_parking'],
        freeParking : json['free_parking'],
        parkingPricePerHr : json['parking_price_per_hr'],
        parkingLocation : json['parking_location'],
    parkingPrivacy : json['parking_privacy'],
    hostlanguage : json['hostlanguage'],
    petsAutorize : json['pets_autorize'],
    partyAutorize : json['party_autorize'],
    smokeAutorize : json['smoke_autorize'],
    kidsAutorize : json['kids_autorize'],
    idRepresentative : json['id_representative'],
    idTown : json['id_town'],
    hotelDescription : json['hotel_description'],
    hostDescription : json['host_description'],
    streetDescription : json['street_description'],
    address : json['address'],
    minPrice : json['min_price'],
    maxPrice : json['max_price'],
    contactPhone : json['contact_phone'],
    contactEmail : json['contact_email'],
    imagePath : json['image_path'],
    );
  }
}
