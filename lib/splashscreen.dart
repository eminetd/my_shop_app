import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/color/colors.dart';
import 'package:my_shop_app/firstscreen.dart';
import 'package:my_shop_app/homescreen.dart';
import 'package:my_shop_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: colors.mywhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.07,
                  width: mediaQuery.size.width * 0.45,
                  child: Center(
                    child: AutoSizeText(
                      'Welcome !',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).textScaleFactor * 50,
                        fontWeight: FontWeight.w400,
                        color: colors.myblack,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    ap.isSignedIn ==
                            true //when true . then fetch shared preference data
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Firstscreen()));
                  },
                  child: Container(
                    height: mediaQuery.size.height * 0.06,
                    width: mediaQuery.size.width * 0.6,
                    decoration: BoxDecoration(
                      color: colors.myblack,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            "Let's Start !",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: colors.mywhite,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor *
                                        20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
