import 'package:dio/dio.dart';

class DioHelper
{
  static Dio? dio;

  static init(){
    dio=Dio(
     BaseOptions(
       baseUrl: 'https://newsapi.org/',
       receiveDataWhenStatusError: true,
     ),
    ) ;
  }
 static Future<Response>getData({required String url,required dynamic quary})

 async{
    return await dio!.get(url,queryParameters: quary);
  }

}