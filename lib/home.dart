import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle/API.dart';
import 'package:toggle/constants.dart';
import 'package:toggle/screen.dart';
import 'package:toggle/time_entries.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String email, name, image;
  List<Time_Entries> _time_entries;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('toggel'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
              width: ScreenUtil.getWidth(context) / 2,
              height: ScreenUtil.getHeight(context),
              child: Column(
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
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.play_arrow),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        width: ScreenUtil.getWidth(context),
        child: _time_entries == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _time_entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return time_entries(_time_entries[index]);
                },
              ),
      ),
    );
  }

  void get_time_entries() {
    API(context).get("time_entries").then((value) {
      _time_entries = [];
      jsonDecode(value.body).forEach((v) {
        setState(() {
          _time_entries.add(Time_Entries.fromJson(v));
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
                        '${approved.description??'Add description'}',
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
                expanded: Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: AutoSizeText(
                          "${approved.start}",
                          minFontSize: 10,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: AutoSizeText(
                              "${approved.stop}",
                              minFontSize: 10,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              // API(context).post(Api_Configuration.increase_update,{
                              //   "request_increase_id": approved.id.toString(),
                              //   "status": 'approved'
                              // }).then((value){
                              //   if(value!=null){
                              //     setState(() {
                              //       showDialog(
                              //         context: context,
                              //         builder: (_) => RusultOverlay(
                              //           value['message'],
                              //           Icons.check_circle_outline,
                              //           Colors.green,
                              //         ),
                              //       );
                              //       getAppointments(
                              //           DateFormat('yyyy-MM-dd').format(date));                                  });
                              //   }
                              // });
                            },
                            child: Container(
                              width: ScreenUtil.getWidth(context) / 6,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 4, top: 4),
                                child: Center(
                                  child: AutoSizeText(
                                    'قبول',
                                    minFontSize: 8,
                                    maxFontSize: 12,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
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
