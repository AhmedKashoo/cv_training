import 'package:dio/dio.dart';

class ShopDioHelper
{
  static Dio dio=Dio();

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,




      ),
    ) ;
  }
  static Future<Response>getData({required String url, dynamic quary,String? token})

  async{
    dio.options.headers={
      "Authorization":token,
      'Lang' :'en'
    };
    return await dio.get(url,queryParameters: quary);
  }
  static Future<Response>postData({required String url, dynamic quary,required dynamic data,String? token})async{
    dio.options.headers={
      "Authorization":token??'',
      'Content-Type':'application/json',
    'Lang' :'en'
    };
    return await dio.post(url,data: data,queryParameters: quary);
  }
  static Future<Response>putData({required String url, dynamic quary,required dynamic data,String? token})async{
    dio.options.headers={
      "Authorization":token??'',
      'Content-Type':'application/json',
      'Lang' :'en'
    };
    return await dio.put(url,data: data,queryParameters: quary);
  }

}