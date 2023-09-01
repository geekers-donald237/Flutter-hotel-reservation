import 'package:hooks_riverpod/hooks_riverpod.dart';

final allAccomodationProvider = StateProvider<int>((ref) {
  return 1;
});

final allAdultsProvider = StateProvider<int>((ref) {
  return 1;
});

final allChildrenProvider = StateProvider<int>((ref) {
  return 0;
});

final LocationCurrentProvider = StateProvider<String>((ref) {
  return 'Votre destination';
});

final LongitudeProvider = StateProvider<double>((ref) {
  return 0.0;
});

final LattitudeProvider = StateProvider<double>((ref) {
  return 0.0;
});

final StringDateProvider = StateProvider<String>((ref) {
  return '';
});
