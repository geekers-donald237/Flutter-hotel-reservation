class DestinationModel {
  final String destination;
  final int accomodation;
  final String dateTravel;
  final int adults;
  final int children;

  DestinationModel({
    required this.destination,
    required this.accomodation,
    required this.dateTravel,
    required this.adults,
    required this.children,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      destination: json['destination'],
      accomodation: json['accomodation'],
      dateTravel: json['dateTravel'],
      adults: json['adults'],
      children: json['children'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'accomodation': accomodation,
      'dateTravel': dateTravel,
      'adults': adults,
      'children': children,
    };
  }
}
