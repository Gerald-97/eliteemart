import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eliteemart/extras/strings.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  String handleRequestError(e) {
    if (e is TimeoutException) {
      e = Strings.requestTimeOutMsg;
    } else {
      e = Strings.connectionErrorMsg;
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
      http.Response response = await http.get('${Strings.base_url}/${Strings.release_version}/user/$id', headers: header);
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
    }
    catch(e) {
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
        headers: header
      );
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
          headers: header
      );

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
}
