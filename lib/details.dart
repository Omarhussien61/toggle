import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle/API.dart';
import 'package:toggle/constants.dart';
import 'package:toggle/screen.dart';
import 'package:toggle/time_entries.dart';



class Details extends StatefulWidget {
  Time_Entries time_Entries;

  Details({this.time_Entries});

  @override
  _DetailsState createState() =>
      _DetailsState();
}

class _DetailsState
    extends State<Details> {


  // List<String> employee = [];
  getProject() {
    API(context).get("project/${widget.time_Entries.uid}").then((value) {
      setState(() {
        //employee = filteredEmployees_data=Employees.fromJson(value).data;
        // for (var i in employees) {
        //   employee.add(i.name);
        // }
      });
    });
  }
  getClint() {
    API(context).get("client/${widget.time_Entries.uid}").then((value) {
      setState(() {
        //employee = filteredEmployees_data=Employees.fromJson(value).data;
        // for (var i in employees) {
        //   employee.add(i.name);
        // }
      });
    });
  }

  @override
  void initState() {

  //  getClint();
  //  getProject();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: AutoSizeText(
          "${widget.time_Entries.description ?? 'Add description'}",
          minFontSize: 10,
          maxLines: 1,
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),

              child: Container(
                padding: const EdgeInsets.all(6.0),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: ScreenUtil.getWidth(context) / 2,
                                child: AutoSizeText(
                                  "${widget.time_Entries}",
                                  minFontSize: 10,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: ScreenUtil.getWidth(context) / 2,
                                child: AutoSizeText(
                                  "${widget.time_Entries.uid},",
                                  minFontSize: 10,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Container(
                        width: ScreenUtil.getWidth(context) /3,
                        child: AutoSizeText(
                          ' # ${widget.time_Entries.id}',
                          minFontSize: 8,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    )   ,
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Container(
                        width: ScreenUtil.getWidth(context) /3,
                        child: AutoSizeText(
                          '${widget.time_Entries.wid}',
                          minFontSize: 8,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: ScreenUtil.getWidth(context) / 10,
                          child: AutoSizeText(
                            ' من ',
                            minFontSize: 10,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),

                        Container(
                          width: ScreenUtil.getWidth(context) / 8,
                          child: AutoSizeText(
                            ' - إلى ',
                            minFontSize: 10,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          width: ScreenUtil.getWidth(context) / 7,
                          child: AutoSizeText(
                            "${widget.time_Entries.description}",
                            minFontSize: 8,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
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

}
