import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:task_manager/data/controller/auth_controller.dart';

class NetworkCaller {
  //get request
 static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Response response = await get(
          uri,
        headers:{
          'token': AuthController.accessToken ?? '',
        },
      );
      _logResponse(url, response);
      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          body: decodedData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: decodedData['data'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  //post request
 static Future<NetworkResponse> postRequest(
    String url,
     {Map<String, dynamic>? body}
  ) async {
    try{
      Uri uri = Uri.parse(url);
      Response response = await post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken ?? '',
        },
        body: jsonEncode(body),
      );
      _logResponse(url, response);
      final decodedData = jsonDecode(response.body);
      if(response.statusCode == 200){
        return NetworkResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          body: decodedData,
        );
      }else{
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: decodedData['data'],
        );
      }
    }catch(e){
      return NetworkResponse(
          isSuccess: false,
          responseCode: -1,
          errorMessage: e.toString(),
      );
    }
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    debugPrint("Url: $url\n"
    "body: $body");
  }

 static void _logResponse(String url, Response response) {
    debugPrint(
      'Url: $url\n'
      'Status code: ${response.body}\n'
      'body: ${response.body}',
    );
  }
}

class NetworkResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic body;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.responseCode,
    this.body,
    this.errorMessage = 'Something went wrong',
  });
}
