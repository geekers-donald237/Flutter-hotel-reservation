import 'package:hooks_riverpod/hooks_riverpod.dart';

final LocationCurrentProvider = StateProvider<String>((ref) {
  return 'Votre Destination';
});

final LongitudeProvider = StateProvider<double>((ref) {
  return 0.0;
});

final LattitudeProvider = StateProvider<double>((ref) {
  return 0.0;
});
