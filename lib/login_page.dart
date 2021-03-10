import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle/constants.dart';
import 'package:toggle/login/login_form.dart';
import 'package:toggle/screen.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil.getHeight(context)/5,
                ),
                Container(
                  height: 100,
                  width: ScreenUtil.getWidth(context) / 2,
                  child:CachedNetworkImage(imageUrl: 'https://demo.7lcart.com/images/7lcart.png',),
                ),
                LoginForm(),

                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          Positioned(
            top: ScreenUtil.getHeight(context)/15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){Navigator.pop(context);}),
              ],
            ),
          ),

        ],
      ),
    );
  }

}
