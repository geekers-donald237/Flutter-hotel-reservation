import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final LocationCurrentProvider = StateProvider<String>((ref) {
  return 'Votre Destination';
});

final PositionProvider = StateProvider<LatLng>((ref) {
  return LatLng(0.0, 0.0);
});
