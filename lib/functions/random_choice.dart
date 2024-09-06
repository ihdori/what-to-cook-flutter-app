import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what2cooke/providers/choice_provider.dart';

int old = 0;

final oldChoiceProvider = StateProvider((ref) => 0);

final randomProvider = StateProvider.family<int, List>((ref, list) {
  final oldChoice = ref.watch(oldChoiceProvider);
  final listLenght = list.length;
  if (listLenght == 0) {
    return old;
  }
  final choice = Random().nextInt(listLenght);
  return choice;
});

int randomChoice(List list) {
  final listLenght = list.length;
  if (listLenght == 0) {
    return 0;
  }
  final choice = Random().nextInt(listLenght);
  return choice;
}
