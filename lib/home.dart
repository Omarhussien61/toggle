import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle/API.dart';
import 'package:toggle/constants.dart';
import 'package:toggle/details.dart';
import 'package:toggle/form.dart';
import 'package:toggle/login_page.dart';
import 'package:toggle/navigator.dart';
import 'package:toggle/screen.dart';
import 'package:toggle/time_entries.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String email, name, image;
  List<Time_Entries> _time_entries;
  List<Time_Entries> _custom_entries;
  DateTime date = DateTime.now();

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        email = prefs.getString("user_email");
        name = prefs.getString("name");
        image = prefs.getString("imageUrl");
      });
    });
    get_time_entries();
    get_time_custom(
        DateFormat("yyyy-MM-dd'T'00:00:00'Z'")
            .format(DateTime.now().subtract(Duration(days: 30))),
        DateFormat("yyyy-MM-dd'T'00:00:00'Z'").format(DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('toggel'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Today',
              ),
              Tab(text: 'last month'),
            ],
          ),
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
                width: ScreenUtil.getWidth(context) / 2,
                height: ScreenUtil.getHeight(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ScreenUtil.getHeight(context) / 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          width: ScreenUtil.getWidth(context) / 5,
                          height: ScreenUtil.getHeight(context) / 20,
                          imageUrl: "$image",
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$name",
                              maxLines: 1,
                            ),
                            Text(
                              "$email",
                              maxLines: 1,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getHeight(context) / 20,
                    ),
                    ListTile(title: Text(
                      "Home",
                      style: TextStyle(
                          color: kPrimaryColor, fontSize: 16),
                    ),) ,
                    ListTile(onTap: (){
                      SharedPreferences.getInstance().then((value){
                        value.clear();
                        Nav.routeReplacement(context, LoginPage());
                      });
                    },
                      title: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 16),
                    ),)
                  ],
                )),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => FormOverlay(),
            );
          },
          child: Icon(Icons.play_arrow),
          backgroundColor: kPrimaryColor,
        ),
        body: TabBarView(
          children: [
            Container(
              width: ScreenUtil.getWidth(context),
              child: _time_entries == null
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _time_entries.length,
                              itemBuilder: (BuildContext context, int index) {
                                return time_entries(_time_entries[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            Container(
              width: ScreenUtil.getWidth(context),
              child: _custom_entries == null
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _custom_entries.length,
                              itemBuilder: (BuildContext context, int index) {
                                return time_entries(_custom_entries[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void get_time_entries() {
    API(context)
        .get(
            "time_entries?start_date=${DateFormat("yyyy-MM-dd'T'00:00:00'Z'").format(DateTime.now())}")
        .then((value) {
      _time_entries = [];
      jsonDecode(value.body).forEach((v) {
        setState(() {
          _time_entries.add(Time_Entries.fromJson(v));
        });
      });
    });
  }

  void get_time_custom(String start, String end) {
    API(context)
        .get("time_entries?start_date=$start&end_date=$end")
        .then((value) {
      _custom_entries = [];
      jsonDecode(value.body).forEach((v) {
        setState(() {
          _custom_entries.add(Time_Entries.fromJson(v));
        });
      });
    });
  }

  Row time_entries(Time_Entries approved) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xffEEEEEE),
            ),
            margin: EdgeInsets.only(bottom: 20, right: 20),
            padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
            child: Container(
              child: ExpandablePanel(
                hasIcon: true,
                iconColor: kPrimaryColor,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                iconPlacement: ExpandablePanelIconPlacement.right,
                header: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        '${approved.description ?? 'Add description'}',
                        minFontSize: 10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AutoSizeText(
                        '${approved.duration}',
                        minFontSize: 10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                expanded: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            AutoSizeText(
                              "start: ${approved.start}",
                              minFontSize: 10,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.grey, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            AutoSizeText(
                              "stop : ${approved.stop}",
                              minFontSize: 10,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        FlatButton(
                          height: 50,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          color: kPrimaryColor,
                          onPressed: () {
                            Nav.route(
                                context,
                                Details(
                                  time_Entries: approved,
                                )
                            );
                          },
                          minWidth: ScreenUtil.getWidth(context) / 10,
                          child: AutoSizeText(
                            'Details',
                            minFontSize: 8,
                            maxLines: 1,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),                    ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
