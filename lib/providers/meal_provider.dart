import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:what2cocke/providers/region_provider.dart';

final mealProvider = FutureProvider.autoDispose<List<Map>>((ref) async {
  final region = ref.watch(regionProvider);
  return await Supabase.instance.client
      .from('meals')
      .select('*')
      .eq('region_id', region);
});
