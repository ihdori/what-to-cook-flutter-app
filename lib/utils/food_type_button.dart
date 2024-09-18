import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:what2cooke/utils/colors.dart';

class FoodTypeButton extends StatelessWidget {
  FoodTypeButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  String text;
  bool isSelected;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: DottedBorder(
        color: isSelected ? orangeRed : gray,
        borderPadding: const EdgeInsets.all(1),
        dashPattern: const [6, 2],
        radius: const Radius.circular(12),
        borderType: BorderType.RRect,
        child: Container(
          alignment: Alignment.center,
          height: 36,
          width: 90,
          decoration: BoxDecoration(
            color: isSelected ? orange : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : const Color.fromARGB(255, 95, 105, 104),
              )),
        ),
      ),
    );
  }
}
