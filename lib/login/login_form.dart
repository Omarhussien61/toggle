import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle/API.dart';
import 'package:toggle/LanguageTranslated.dart';
import 'package:toggle/ResultOverlay.dart';
import 'package:toggle/constants.dart';
import 'package:toggle/custom_textfield.dart';
import 'package:toggle/home.dart';
import 'package:toggle/login/login_form_model.dart';
import 'package:toggle/navigator.dart';
import 'package:toggle/screen.dart';
import 'package:toggle/user_model.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();
  bool passwordVisible = false;
  String CountryNo='';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 24, right: 42, left: 42),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: MyTextFormField(
               // intialLabel: 'sherifeldoksh8@gmail.com',
                Keyboard_Type: TextInputType.emailAddress,
                textDirection: TextDirection.ltr,
                labelText: getTransrlate(context, 'Email'),
                hintText:  getTransrlate(context, 'Email'),
                isPhone: true,
                validator: (String value) {
                  if (value.isEmpty) {
                    return  getTransrlate(context, 'Email');
                  } else if (value.length < 9) {
                    return getTransrlate(context, 'invalidemail');
                  }
                  _formKey.currentState.save();
                  return null;
                },
                onSaved: (String value) {
                  model.email=value;
                },
              ),
            ),
            MyTextFormField(
             // intialLabel: '123456',
              labelText: getTransrlate(context, 'password'),
              hintText:  getTransrlate(context, 'password'),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              isPassword: passwordVisible,
              validator: (String value) {
                if (value.length < 7) {
                  return  getTransrlate(context, 'password'+'< 7');
                }
                _formKey.currentState.save();
                return null;
              },
              onSaved: (String value) {
                model.password = value;
              },
            ),
            Container(
              height: 42,
              width: ScreenUtil.getWidth(context),
              margin: EdgeInsets.only(top: 32, bottom: 12),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                ),
                color: kPrimaryColor,
                onPressed: () async {

                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    //setState(() => _isLoading = true);
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    API(context).get('me',model: model).then((value)  {
                      if(value!=null){
                        if (value.statusCode == 200) {
                          var user = new User.fromJson(jsonDecode(value.body)['data']);
                         print(user.email);
                          prefs.setString("user_email", user.email);
                          prefs.setString("password", model.password);
                          prefs.setString("name", user.fullname);
                          prefs.setString("token", user.apiToken);
                          prefs.setInt("user_id",  user.id);
                          prefs.setInt("w_id",  user.defaultWid);
                          prefs.setString("imageUrl",  user.imageUrl);
                          showDialog(
                            context: context,
                            builder: (_) => ResultOverlay("Login Success"),
                          );
                          Timer(
                              Duration(seconds: 3),
                                  () => Nav.routeReplacement(context, Home())
                          );
                        }
                        else{
                          Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: kPrimaryColor,
                              content: Text('Error registration')));
                        }}
                    });

                  }

                },
                child: Text(
                  getTransrlate(context, 'login'),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
