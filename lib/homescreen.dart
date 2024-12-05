// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_shop_app/color/colors.dart';
// import 'package:badges/badges.dart' as badges;
import 'package:my_shop_app/item_tile.dart';
import 'package:my_shop_app/model/cart.dart';
import 'package:my_shop_app/my_cart.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: mediaQuery.viewInsets.left + 30,
              bottom: mediaQuery.viewInsets.bottom + 20,
            ),
            child: FloatingActionButton.extended(
              heroTag: 'My Cart',
              extendedPadding: EdgeInsets.symmetric(horizontal: 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: colors.myblack,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              label: Text(
                'My Cart',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor * 20),
              ),
            ),
          ),
        ],
      ),
      key: _key,
      // drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          'Homepage',
          style: TextStyle(color: colors.myblack),
        ),
        centerTitle: true,
        backgroundColor: colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: colors.myblack,
          ),
          onPressed: () {
            _key.currentState?.openDrawer();
          },
        ),
        // actions: [
        //   Center(
        //     child: InkWell(
        //       onTap: () {},
        //       child: Icon(
        //         Icons.search,
        //         color: colors.myblack,
        //       ),
        //     ),
        //   ),
        //   SizedBox(
        //     width: mediaQuery.size.width * 0.05,
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Text("Tap on the Product for Add to Cart"),
                SizedBox(
                  child: Consumer<CartModel>(
                    builder: (context, value, child) {
                      return GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(12.0),
                          itemCount: value.shopitem.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.2,
                          ),
                          itemBuilder: (content, index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ProductPage()));
                              },
                              child: PItemTile(
                                itemName: value.shopitem[index][0],
                                itemPrice: value.shopitem[index][1],
                                imagePath: value.shopitem[index][2],
                                Color: value.shopitem[index][3],
                                onPressed: () {
                                  Provider.of<CartModel>(context, listen: false)
                                      .addItemToCart(index);
                                },
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
