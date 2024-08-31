import 'dart:math';

int randomChoice(List list) {
  final listLenght = list.length;
  final choice = Random().nextInt(listLenght);
  return choice;
}
