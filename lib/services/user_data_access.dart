import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import '../data/learner.dart';
import '../global_items.dart';
import '../user.dart';

class UserLogin {

  void main(List<String> arguments) async {
  }
  String convertEmailToHash(String email)
  {
    String result = "";

    var bytes1 = utf8.encode(email);         // data being hashed
    var digest1 = sha256.convert(bytes1);         // Hashing Process
    print("Digest as bytes: ${digest1.bytes}");   // Print Bytes
    print("Digest as hex string: $digest1");      // Print After Hashing

    // Here's a bonus: var output = sha256.convert(utf8.encode(input)).toString()
    return result;
  }
  Future<void> userLogin(String userEmail) async
  {
    // https://d1.allproview.com.au:8443/apvdemo/api/v1/Projects/70

    var url ;
    if (GlobalItems.prodServer)
      url = Uri.https(GlobalItems.hostLocation, '${GlobalItems.apiLocation}User/Auth');
    else
      url = Uri.http(GlobalItems.hostLocation, '${GlobalItems.apiLocation}User/Auth');

    // Await the http get response, then decode the json-formatted response.
    // print('$userId-$password');
    final response = await http.post(url, headers: <String, String>{
      io.HttpHeaders.contentTypeHeader: 'application/json',
    },
        body: convert.jsonEncode(<String, String>{
          'LoginId': userEmail,
          // 'Password': password
        }));

    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      // var itemCount = jsonResponse['totalItems'];
      // print('Number of books about http: $itemCount.');
      /*
      String data = response.body;
      print(data);
      var decodedData = jsonDecode(data);
*/
      print(jsonResponse);
      User.apiKey=jsonResponse['api_key'];
      User.userId=jsonResponse['userId'];
      return;
    } else {
      print('Response ERROR');
      print('Request failed with status: ${response.statusCode}.');
      User.userId=0;
      return ;
    }
  }
  Future<void> learnerRegister(String userEmail, String contactNo, String firstName, lastName) async
  {
    Map<String, dynamic> jsonResponse = {};
    // https://d1.allproview.com.au:8443/apvdemo/api/v1/Projects/70
    print('---Learner Register 1');
    print('---Learner email ' + userEmail);
    print('---Learner firstName ' + firstName);
    print('---Learner LastName ' + lastName);
    var url ;
    if (GlobalItems.prodServer)
      url = Uri.https(GlobalItems.hostLocation, '${GlobalItems.apiLocation}Learners');
    else
      url = Uri.http(GlobalItems.hostLocation, '${GlobalItems.apiLocation}Learners');

    // Await the http get response, then decode the json-formatted response.
    // print('$userId-$password');
    final response = await http.post(url, headers: <String, String>{
      io.HttpHeaders.contentTypeHeader: 'application/json',
    },
        body: convert.jsonEncode(<String, String>{
          'LearnerEMail': userEmail,
          'ContactNo': contactNo,
          'FirstName': firstName,
          'LastName': lastName
        }));
    print ('---HTTP Status Learner Register ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      // var itemCount = jsonResponse['totalItems'];
       print('Added User successfully');

      String data = response.body;
      print(data);
      var decodedData = jsonDecode(data);

      print(jsonResponse);
      Learner.isRegistered=true;
      Learner.learnerId = jsonResponse['LearnerId'];
     // User.apiKey=jsonResponse['api_key'];
      //User.userId=jsonResponse['userId'];
      return;
    } else {
      print('---Response ERROR');
      print('Lessons Status: ' + jsonResponse['LessonsStatus']);
      print('Lessons StatusMsg: ' + jsonResponse['LessonsStatusMsg']);
      print('Request failed with status: ${response.statusCode}.');
      Learner.isRegistered=false;

      return ;
    }
  }

}