// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:my_shop_app/color/colors.dart';
import 'package:my_shop_app/model/search_modal.dart';

class Seacrh extends StatefulWidget {
  const Seacrh({super.key});

  @override
  State<Seacrh> createState() => _SeacrhState();
}

class _SeacrhState extends State<Seacrh> {
  String? userselected;
  static List<SearchProducts> product_list = [
    SearchProducts(
      'Banana',
      "Fresh Banana's",
      100,
      'assets/banana.png',
    ),
    SearchProducts(
      'Kiwi',
      'Fresh kiwi',
      130,
      'assets/kiwi.png',
    ),
    SearchProducts(
      'Chicken',
      'Boneless chicken',
      220,
      'assets/chicken.png',
    ),
    SearchProducts(
      'Oranges',
      'Fresh oranges',
      150,
      'assets/ora.png',
    ),
    SearchProducts(
      'Strawberry',
      'Freshh Strawberry',
      120,
      'assets/straw.png',
    ),
    SearchProducts(
      'Water',
      'water bottle 1 ltr',
      10,
      'assets/water.png',
    ),
  ];
  List<SearchProducts> display_list = List.from(product_list);
  void updateList(String value) {
    setState(() {
      display_list = product_list
          .where((element) => element.product_title!
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              child: display_list.isEmpty
                  ? Flexible(
                      child: Text(
                        'No data found',
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(12),
                      itemCount: display_list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: colors.mygrey),
                            child: ListTile(
                              leading: Image.network(
                                display_list[index].product_image!,
                                height: 30,
                              ),
                              title: Text(
                                display_list[index].product_title!,
                                style: TextStyle(
                                  color: colors.mywhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "${display_list[index].price}",
                                style: TextStyle(
                                  color: colors.mywhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
        ],
      ),
    );
  }
}
