import 'package:flutter/material.dart';
import 'package:what2cooke/utils/colors.dart';

class WhatToEatButton extends StatelessWidget {
  const WhatToEatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'result');
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width - 160,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(colors: [
              turquois,
              Color.fromARGB(255, 35, 133, 121),
            ])),
        child: const Text(
          textDirection: TextDirection.rtl,
          'كَلي شطبخ؟',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
