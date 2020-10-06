import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eliteemart/extras/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  String handleRequestError(e) {
    if (e is TimeoutException) {
      e = Strings.requestTimeOutMsg;
    } else if (e is HttpException) {
      e = Strings.connectionErrorMsg;
    } else {
      e = "Endpoint connection error";
    }
    return e;
  }

  Future<dynamic> registerUser(
      String name, String email, String password) async {
    var body = {"fullname": name, "email": email, "password": password};
    try {
      http.Response response = await http.post(
          '${Strings.base_url}/${Strings.release_version}/auth/signup',
          body: body);
      var decoded = await jsonDecode(response.body);

      if (decoded != null) {
        Map<String, dynamic> registerUserResponse() => {
              'statusCode': response.statusCode,
              'status': decoded['status'],
              'message': decoded['message'],
              'data': decoded['data'],
            };
        return registerUserResponse();
      } else {
        Map<String, dynamic> registerUserResponse() => {
              'statusCode': response.statusCode,
              'status': decoded['status'],
              'message': 'No data received'
            };
        return registerUserResponse();
      }
    } catch (e) {
      handleRequestError(e);
    }
  }

  Future<dynamic> loginUser(String email, String password) async {
    var body = {"email": email, "password": password};

    try {
      http.Response response = await http.post(
          '${Strings.base_url}/${Strings.release_version}/auth/signin',
          body: body);
      var decoded = await jsonDecode(response.body);

      if (decoded['data'] != null) {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "status": decoded['status'],
              "message": decoded['message'],
              "data": decoded['data'],
              "token": decoded['data']['token']
            };
        return responseData();
      } else {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "status": decoded['status'],
              "message": decoded['message'],
            };
        return responseData();
      }
    } catch (e) {
      handleRequestError(e);
    }
  }

  Future<dynamic> getUserProfile(int id, String token) async {
    var header = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      http.Response response = await http.get(
          '${Strings.base_url}/${Strings.release_version}/user/$id',
          headers: header);
      var decoded = await jsonDecode(response.body);

      if (decoded['data'] != null) {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "status": decoded['status'],
              "message": decoded['message'],
              "data": decoded['data'],
            };
        return responseData();
      } else {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "status": decoded['status'],
              "message": decoded['message'],
            };
        return responseData();
      }
    } catch (e) {
      handleRequestError(e);
    }
  }

  Future<dynamic> updateUserProfile(
    int id,
    String firstName,
    String lastName,
    String email,
    token,
  ) async {
    var body = {"fullname": '$firstName $lastName', "email": email};
    var header = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      http.Response response = await http.put(
          '${Strings.base_url}/${Strings.release_version}/user/$id',
          body: body,
          headers: header);
      var decoded = await jsonDecode(response.body);
      if (response.statusCode < 300) {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "status": decoded['status'],
              "message": decoded['message'],
            };
        return responseData();
      } else {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "status": decoded['status'],
              "message": decoded['message'],
            };
        return responseData();
      }
    } catch (e) {
      handleRequestError(e);
    }
  }

  Future<dynamic> updateUserPassword(
    int id,
    String password,
    String token,
  ) async {
    var body = {"password": '$password'};
    var header = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      http.Response response = await http.patch(
          '${Strings.base_url}/${Strings.release_version}/user/$id',
          body: body,
          headers: header);

      var decoded = await jsonDecode(response.body);

      if (response.statusCode < 300) {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "status": decoded['status'],
              "message": decoded['message'],
            };
        return responseData();
      } else {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "status": decoded['status'],
              "message": decoded['message'],
            };
        return responseData();
      }
    } catch (e) {
      handleRequestError(e);
    }
  }

  Future<dynamic> getAllProducts() async {
    try {
      http.Response response = await http
          .get('${Strings.base_url}/${Strings.release_version}/product');

      var decoded = await jsonDecode(response.body);

      if (response.statusCode < 300) {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "message": decoded['message'],
              "data": decoded['data']
            };
        return responseData();
      } else {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "message": decoded['message'],
            };
        return responseData();
      }
    } catch (e) {
      handleRequestError(e);
    }
  }

  Future<dynamic> getCategoryProducts(int id) async {
    try {
      http.Response response = await http.get(
          '${Strings.base_url}/${Strings.release_version}/product/sub-category/$id');

      var decoded = await jsonDecode(response.body);

      if (response.statusCode < 300) {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "message": decoded['message'],
              "data": decoded['data']
            };
        return responseData();
      } else {
        Map<String, dynamic> responseData() => {
              "statusCode": response.statusCode,
              "message": decoded['message'],
            };
        return responseData();
      }
    } catch (e) {
      handleRequestError(e);
    }
  }

  Future<dynamic> getAllSubCategories() async {
    try {
      http.Response response = await http
          .get('${Strings.base_url}/${Strings.release_version}/sub-category');

      Map responseBody = json.decode(response.body);

      if (responseBody['data'] == null) {
        Map<String, dynamic> responseData() => {
              'status': response.statusCode,
              'message': responseBody['message'],
            };
        return responseData();
      } else {
        Map<String, dynamic> responseData() => {
              'status': response.statusCode,
              'data': responseBody['data'],
            };
        return responseData();
      }
    } catch (e) {
      handleRequestError(e);
    }
  }

  Future<dynamic> getUserCart(id, token) async {
    try {
      var header = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
      http.Response response = await http.get(
        '${Strings.base_url}/${Strings.release_version}/user/$id/cart',
        headers: header,
      );

      Map responseBody = json.decode(response.body);

      if (response.statusCode >= 300 && response.statusCode < 500) {
        Map<String, dynamic> responseData() => {
              'status': response.statusCode,
              'message': responseBody['message'],
            };
        return responseData();
      } else {
        Map<String, dynamic> responseData() => {
              'status': response.statusCode,
              'message': responseBody['message'],
              'data': responseBody['data'],
            };
        return responseData();
      }
    } catch (e) {
      handleRequestError(e);
    }
  }

  Future<dynamic> addToCart(id, token, payload) async {
    print("ID: $id, token: $token, body: $payload");
    try {
      var header = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      };

      var body = jsonEncode(payload);

      http.Response response = await http.post(
        '${Strings.base_url}/${Strings.release_version}/user/$id/cart',
        headers: header,
        body: body,
      );

      var decoded = jsonDecode(response.body);

      print("Decoded response: $decoded");

      if(response.statusCode < 300) {
        Map<String, dynamic> responseData() => {
          'status': response.statusCode,
          'message': decoded['message'],
          'data': decoded['data']
        };
        return responseData();
      } else {
        Map<String, dynamic> responseData() => {
          'status': response.statusCode,
          'message': decoded['message'],
        };
        return responseData();
      }
    } catch (e) {
      handleRequestError(e);
    }
  }
}
