import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle/API.dart';
import 'package:toggle/LanguageTranslated.dart';
import 'package:toggle/clints.dart';
import 'package:toggle/constants.dart';
import 'package:toggle/custom_textfield.dart';
import 'package:toggle/drop_down_menu/find_dropdown.dart';
import 'package:toggle/screen.dart';

class FormOverlay extends StatefulWidget {
  FormOverlay();

  @override
  State<StatefulWidget> createState() => FormOverlayState();
}

class FormOverlayState extends State<FormOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> scaleAnimation;
  final _formKey = GlobalKey<FormState>();
  List<Client> client;
  @override
  void initState() {
    super.initState();
    getCity();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyTextFormField(
                        // intialLabel: 'sherifeldoksh8@gmail.com',
                        Keyboard_Type: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        labelText: getTransrlate(context, 'title'),
                        hintText: getTransrlate(context, 'title'),
                        isPhone: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return getTransrlate(context, 'title');
                          } else if (value.length < 9) {
                            return getTransrlate(context, 'title');
                          }
                          _formKey.currentState.save();
                          return null;
                        },
                        onSaved: (String value) {
                          // model.email=value;
                        },
                      ),
                      MyTextFormField(
                        // intialLabel: 'sherifeldoksh8@gmail.com',
                        Keyboard_Type: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        labelText: getTransrlate(context, 'start '),
                        hintText: getTransrlate(context, 'start'),
                        isPhone: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return getTransrlate(context, 'start');
                          } else if (value.length < 9) {
                            return getTransrlate(context, 'start');
                          }
                          _formKey.currentState.save();
                          return null;
                        },
                        onSaved: (String value) {
                          // model.email=value;
                        },
                      ),
                      MyTextFormField(
                        // intialLabel: 'sherifeldoksh8@gmail.com',
                        Keyboard_Type: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        labelText: getTransrlate(context, 'client'),
                        hintText: getTransrlate(context, 'client'),
                        isPhone: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return getTransrlate(context, 'client');
                          } else if (value.length < 9) {
                            return getTransrlate(context, 'client');
                          }
                          _formKey.currentState.save();
                          return null;
                        },
                        onSaved: (String value) {
                          // model.email=value;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: FindDropdown<Client>(
                            items: client,
                            dropdownBuilder: (context, selectedText) => Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    height: 50,
                                    width: ScreenUtil.getWidth(context) / 1.1,
                                    decoration: BoxDecoration(
                                        color: Color(0xfff3f3f4),
                                        borderRadius: BorderRadius.circular(3),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.2),
                                            blurRadius: 1.0,
                                            // soften the shadow
                                            spreadRadius: 0.0,
                                            //extend the shadow
                                            offset: Offset(
                                              0.0,
                                              // Move to right 10  horizontally
                                              1.0, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ]),
                                    child: Center(
                                        child: Text(selectedText == null
                                            ? ' '
                                            : selectedText.name)))),
                            dropdownItemBuilder: (context, item, isSelected) =>
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                        color: isSelected
                                            ? kPrimaryColor
                                            : Color(0xFF5D6A78),
                                        fontSize: isSelected ? 20 : 17,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w600),
                                  ),
                                ),
                            onChanged: (item) {
                              setState(() {
                                //citycontroler.text = item.id.toString();
                              });
                            },
                            labelStyle: TextStyle(fontSize: 20),
                            titleStyle: TextStyle(fontSize: 20),
                            label: getTransrlate(context, 'client'),
                            showSearchBox: true,
                            isUnderLine: false),
                      ),
                      FlatButton(onPressed: () {}, child: Text('OK'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getCity() {
    API(context).get('clients').then((value) {
      client = [];
      jsonDecode(value.body).forEach((v) {
        setState(() {
          client.add(Client.fromJson(v));
        });
      });
    });
  }
}
