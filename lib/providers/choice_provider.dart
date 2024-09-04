import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what2cooke/functions/random_choice.dart';

final choiceProvider = StateProvider.family<int, List>((ref, list) {
  return randomChoice(list);
});
