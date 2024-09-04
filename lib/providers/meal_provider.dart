import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:what2cooke/providers/region_provider.dart';

final mealProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final region = ref.watch(regionProvider);
  return await Supabase.instance.client.rpc('get_meal_info', params: {
    'region_id': 2,
    'time_id': 1,
  });
});

// final mealProvider2 = FutureProvider.autoDispose<List<Map>>((ref) async {
//   final region = ref.watch(regionProvider);
//   return await Supabase.instance.client
//       .from('meals')
//       .select('*')
//       .match({'region_id': 1});
// });
