import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import '../model/sign_in_model.dart';
import '../model/sign_up_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  var userId;
  Future<SignupResponseModel> register(SignupRequestModel requestModel) async {

    final url = Uri.parse('https://api.homnics.com/user-api/account');
    final headers = {'Content-Type': 'application/json' ''};
    //log(requestModel.toJson() as String );
    final response = await http.post(url, headers: headers, body: jsonEncode(requestModel));

    log('User Response = ${response.body}');
    if (response.statusCode == 200 ) {
      final responseData = json.decode(response.body);
        userId = responseData['userId'];
       print('User ID: $userId');
      return SignupResponseModel.fromJson(
        json.decode(response.body),
        
      );
  //     if (response.statusCode == 200) {
  //   final responseData = json.decode(response.body);
  //   final userId = responseData['user_id'];
  //   print('User ID: $userId');
  // } else {
  //   print('Request failed with status: ${response.statusCode}.');
  // }
      //|| response.statusCode == 400
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<SigninResponseModel> login(SigninRequestModel requestModel) async {

    final url = Uri.parse('https://api.homnics.com/user-api/authentication/token');
    final headers = {'Content-Type': 'application/json'};
    //log(requestModel.toJson() as String );
    final response = await http.post(url, headers: headers, body: jsonEncode(requestModel));
    //var token  =json['token'];

    log('User Response = ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 400) {
      return SigninResponseModel.fromJson(
        json.decode(response.body),
        
      );
      
    } else {
      throw Exception('Failed to load data!');
    }
  }
     
  void confirmEmailById(String userId, String token) async {

    var queryParameters = {
      'param1': token,
    };

    final uri = Uri.http('www.api.homnics.com', '/user-api/account/$userId/confirm-email', queryParameters );
    var response = await http.get(uri, headers: {

  HttpHeaders.contentTypeHeader: 'application/json',
});

print('ssssssssssssssssssssssssssssssss $userId and $token');
   

    if (response.statusCode == 200 || response.statusCode == 400) {
     
        
    print('aaaaaaaaaaaaaaaaaaaaaaa successful');
      
    } else {
    print('fffffffffffffffffffffffffff Failed');
    }
  }

  // static Future<bool> confirmEmailById(String userId) async{

  //    //delete the item 
  //   final url ='https://api.nstack.in/v1/todos/$userId/confirm-email';
  //   final uri = Uri.parse(url);

  //   final response = await http.post(uri);
  //   return response.statusCode == 200;
  // }

}