import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle/API.dart';
import 'package:toggle/ResultOverlay.dart';
import 'package:toggle/constants.dart';
import 'package:toggle/home.dart';
import 'package:toggle/login_page.dart';
import 'package:toggle/navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () => _auth());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: kPrimaryColor,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(35),
                  child: CachedNetworkImage(
                    imageUrl: 'https://cdn.logo.com/hotlink-ok/logo-social-sq.png',
                  ),
                ),
              ),
              // Text(
              //   'Logo App Powered By 7lSoft',
              //   style: TextStyle(
              //       fontWeight: FontWeight.w800, color: kPrimaryColor),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void _auth() async {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('user_email') != null) {
        API(context).get('me').then((value) {
          if (value != null) {
            if (value.statusCode == 200) {
              Nav.routeReplacement(context, Home());

            } else {
              showDialog(
                  context: context,
                  builder: (_) => ResultOverlay('Error registration'));
            }
          }
        });
      } else {
        Nav.routeReplacement(context, LoginPage());
      }
    });
  }
}
