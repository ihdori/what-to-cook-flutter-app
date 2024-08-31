import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what2cocke/providers/meal_region_controler_provider.dart';

final regionProvider = StateProvider<int>((ref) {
  final isIraqiRegionSelected = ref.watch(iraqiMealRegionControllerProvider);

  return isIraqiRegionSelected ? 1 : 2;
});
