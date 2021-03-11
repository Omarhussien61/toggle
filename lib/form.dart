import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle/API.dart';
import 'package:toggle/LanguageTranslated.dart';
import 'package:toggle/clints.dart';
import 'package:toggle/constants.dart';
import 'package:toggle/custom_textfield.dart';
import 'package:toggle/drop_down_menu/find_dropdown.dart';
import 'package:toggle/project.dart';
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
  List<Project> project;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    getCity();
    getProject();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: ScreenUtil.getWidth(context)/2.5,
                            child: MyTextFormField(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.date_range,
                                  color: kPrimaryColor,
                                ),
                                onPressed: (){
                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: false,
                                      minTime: selectedDate, onChanged: (date) {
                                        //   fromcontroler.text = DateFormat.yMd('ar').add_jm().format(date);
                                        //from = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
                                      }, locale: LocaleType.ar);
                                },
                              ),
                              enabled: false,
                              // intialLabel: 'sherifeldoksh8@gmail.com',
                              Keyboard_Type: TextInputType.emailAddress,
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
                          ),
                          Container(
                            width: ScreenUtil.getWidth(context)/2.5,

                            child: MyTextFormField(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.date_range,
                                  color: kPrimaryColor,
                                ),
                                onPressed: (){
                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: false,
                                      minTime: selectedDate, onChanged: (date) {
                                        //   fromcontroler.text = DateFormat.yMd('ar').add_jm().format(date);
                                        //from = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
                                      }, locale: LocaleType.ar);
                                },
                              ),

                              // intialLabel: 'sherifeldoksh8@gmail.com',
                              Keyboard_Type: TextInputType.emailAddress,
                              labelText: getTransrlate(context, 'end '),
                              hintText: getTransrlate(context, 'end'),
                              enabled: false,
                              isPhone: true,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return getTransrlate(context, 'end');
                                } else if (value.length < 9) {
                                  return getTransrlate(context, 'end');
                                }
                                _formKey.currentState.save();
                                return null;
                              },
                              onSaved: (String value) {
                                // model.email=value;
                              },
                            ),
                          ),
                        ],
                      ),
                      MyTextFormField(
                        // intialLabel: 'sherifeldoksh8@gmail.com',
                        Keyboard_Type: TextInputType.emailAddress,
                        labelText: getTransrlate(context, 'duration '),
                        hintText: getTransrlate(context, 'duration'),
                        isPhone: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return getTransrlate(context, 'duration');
                          } else if (value.length < 9) {
                            return getTransrlate(context, 'duration');
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
                        child: FindDropdown<Project>(
                            items: project,
                            dropdownBuilder: (context, selectedText) =>
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        height: 50,
                                        width:
                                        ScreenUtil.getWidth(context) /
                                            1.1,
                                        decoration: BoxDecoration(
                                            color: Color(0xfff3f3f4),
                                            borderRadius:
                                            BorderRadius.circular(3),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(.2),
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
                                                : "${selectedText.name}")))),
                            dropdownItemBuilder:
                                (context, item, isSelected) =>
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
                            onChanged: (Project item) {
                              setState(() {
                                // _cityController.text=item.id.toString();
                              });
                            },
                            validate: (Project value) {
                              if (value.id
                                  .toString()
                                  .isEmpty) {
                                return getTransrlate(context, 'City');
                              }
                            },
                            selectedItem: new Project(
                                name: getTransrlate(context, 'project')),
                            isUnderLine: true
                        ),

                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: FindDropdown<Client>(
                            items: client,
                            dropdownBuilder: (context, selectedText) =>
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        height: 50,
                                        width:
                                        ScreenUtil.getWidth(context) /
                                            1.1,
                                        decoration: BoxDecoration(
                                            color: Color(0xfff3f3f4),
                                            borderRadius:
                                            BorderRadius.circular(3),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(.2),
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
                            dropdownItemBuilder:
                                (context, item, isSelected) =>
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
                            onChanged: (Client item) {
                              setState(() {
                                // _cityController.text=item.id.toString();
                              });
                            },
                            validate: (Client value) {
                              if (value.id
                                  .toString()
                                  .isEmpty) {
                                return getTransrlate(context, 'City');
                              }
                            },
                            selectedItem: new Client(
                                name: getTransrlate(context, 'client')),
                            isUnderLine: true
                        ),

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
  getProject() {
    SharedPreferences.getInstance().then((value){
      API(context).get('workspaces/${value.getInt('w_id')}/projects').then((value) {
        project = [];
        jsonDecode(value.body).forEach((v) {
          setState(() {
            project.add(Project.fromJson(v));
          });
        });
      });
    });

  }
}
