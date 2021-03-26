import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:watcher_app_for_securityguard/ClassList/ResponseClass.dart';
import 'package:watcher_app_for_securityguard/Constants/StringConstants.dart';

Dio dio = new Dio();

class Services {
  static Future<ResponseDataClass> apiHandler({
    @required apiName,
    body,
  }) async {
    String url = api_url + "$apiName";
    var header = Options(
      headers: {
        "authorization": "$api_token", // set content-length
      },
    );
    var response;
    try {
      print("API CALL");
      print("API URL = "+url);
      if (body == null) {
        response = await dio.post(url, options: header);
      } else {
        response = await dio.post(url, data: body, options: header);
      }
      if (response.statusCode == 200) {
        ResponseDataClass responseData = new ResponseDataClass(
            Message: "No Data", IsSuccess: false, Data: "");
        var data = response.data;
        responseData.Message = data["Message"];
        responseData.IsSuccess = data["IsSuccess"];
        responseData.Data = data["Data"];

        return responseData;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Catch error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
