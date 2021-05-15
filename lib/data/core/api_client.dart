import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_constants.dart';

class APIClient {
  static Dio dio;
  static Response response;
  var storage;

  APIClient() {
    dio = Dio();
    storage = FlutterSecureStorage();
  }

  dynamic postAuthData(String resource, dynamic body) async {
    try {
      response = await dio.post(
          '${APIConstants.PROD_BASE_URL}${APIConstants.AUTH_SEGMENT}/$resource',
          data: body);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        print(response.data);
        return response.data;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.message);
      }
    }
  }

  dynamic getUserProfile({String pathSegment, String userId}) async {
    String token = await storage.read(key: APIConstants.ACCESS_TOKEN_KEY);
    print('AccessToken in GetProfile() is $token');

    dio.options.headers['authorization'] = 'Bearer $token';

    Map<String, String> userIdMap = {"id": userId};

    try {
      response = await dio.post(
          '${APIConstants.PROD_BASE_URL}${APIConstants.USER_SEGMENT}/$pathSegment',
          data: userIdMap);
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (err) {
      if (err.response != null) {
        print(err.response.data);
      } else {
        print(err.message);
      }
    }
  }

  dynamic editProfileBio({String pathSegment, dynamic body}) async {
    String token = await storage.read(key: APIConstants.ACCESS_TOKEN_KEY);
    print('AccessToken in EditProfile() is $token');

    dio.options.headers['authorization'] = 'Bearer $token';

    try {
      response = await dio.post(
          '${APIConstants.PROD_BASE_URL}${APIConstants.USER_SEGMENT}/$pathSegment',
          data: body);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        print(response.data);
        return response.data;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.message);
      }
    }

  }

  dynamic getListOfModelItems({String url}) async {
    try {
      response = await dio.get(
          url
      );
      if (response.statusCode == 200) {
        print('response from api-client\n ${response.data} ');
        return response.data;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (err) {
      if (err.response != null) {
        print(err.response.data);
      } else {
        print(err.message);
      }
    }
  }

  dynamic addCartItem({String resource, dynamic body}) async {
    try {
      response = await dio.post(
          '${APIConstants.PROD_BASE_URL}${APIConstants.CART_SEGMENT}/$resource',
          data: body);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        print(response.data);
        return response.data;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.message);
      }
    }
  }

  dynamic deleteCartItem({String resource, dynamic body}) async {
    try {
      response = await dio.post(
          '${APIConstants.PROD_BASE_URL}${APIConstants.CART_SEGMENT}/$resource',
          data: body);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        print(response.data);
        return response.data;
      } else {
        print(response.statusCode);
        print(response.statusMessage);
        throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.message);
      }
    }
  }

  dynamic deleteAllCartItems({String resource}) async {
    try {
      response = await dio.delete(
        '${APIConstants.PROD_BASE_URL}${APIConstants.CART_SEGMENT}/$resource',
      );
      print(response.statusCode);
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.message);
      }
    }
  }

}