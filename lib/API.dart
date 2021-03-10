import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle/Maintenance.dart';
import 'package:toggle/login/login_form_model.dart';
import 'package:toggle/navigator.dart';


class API {

  BuildContext context;

  API(this.context) ;

  get(String url,{Model model}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String full_url =
        '${GlobalConfiguration().getString('api_base_url')}$url';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('${model==null?prefs.getString('user_email'):model.email}:${model==null?prefs.getString('password'):model.password}'));
    try {
      http.Response response = await http.get(full_url, headers: {
        'Authorization': '$basicAuth',
      });
      print(response.body);
      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: response.body,
            ));
      } else if (response.statusCode == 404) {
        Nav.route(
            context,
            Maintenance(
              erorr: full_url + '\n' + response.body,
            ));
      } else {
        return response;
      }
    } catch (e) {
      //Nav.route(context, Maintenance());
    } finally {}
  }
}
