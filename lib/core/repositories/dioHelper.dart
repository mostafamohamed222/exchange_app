import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static late Dio dio;

  // use it in splash screen to work dio 
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.exchangerate.host/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  
  static Future<Response> getSymobles(
      {required String url}) async {
    return await dio.get(
      url,
    );
    
  }
  static Future<Response> postRateRequest(
      {required String url, required Map<String, dynamic> values}) async {
    return await dio.get(
      url,
      queryParameters: values,
    );
  }
}