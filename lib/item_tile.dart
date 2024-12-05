// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:my_shop_app/color/colors.dart';

class PItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final Color;
  void Function()? onPressed;
  PItemTile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.Color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color, borderRadius: BorderRadius.circular(20)),
        height: mediaQuery.size.height * 0.18,
        width: mediaQuery.size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imagePath,
              height: 50,
            ),
            Text(
              itemName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: colors.mywhite,
              ),
            ),
            MaterialButton(
              onPressed: onPressed,
              color: colors.myblack,
              child: Text(
                "Rs.$itemPrice",
                style: TextStyle(
                  color: colors.mywhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
