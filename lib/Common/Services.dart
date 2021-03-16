import 'dart:async';

import 'package:dio/dio.dart';

const String api_url = "https://watcher03.herokuapp.com/";
const String api_token = "RvHiQ6J4QJoAMeA0ysCw-HJklmBHklmnknNJn-hghJUdksjH";
Dio dio = new Dio();

class Services {
  static Future<List> Login(api_name, body) async {
    String url = api_url + api_name;
    //String url = api_url + 'api/staff/getAllidentityCategory';
    print("API Login URL = $url");
    var headers = Options(
      headers: {
        "authorization": "$api_token",
      },
    );
    Response response = await dio.post(url, data: body, options: headers);
    try {
      if (response.statusCode == 200) {
        List list = [];
        var responseData = response.data;
        if (responseData["IsSuccess"] == true &&
            responseData["Data"].length > 0) {
          list = responseData["Data"];
        } else {}
        return list;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
