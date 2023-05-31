import 'dart:convert' as convert;
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';

import '../data/coach.dart';
import '../global_items.dart';
import '../user.dart';

class CoachService
{
  Future<List<Coach>> getCoaches(int orgId)  async {

    final queryParameters = {
       'userId': User.userId.toString(),
       'api_key': User.apiKey,
      // 'description':filter,
      //'param2': 'two',
    };

    var url ;
    if (GlobalItems.prodServer)
      url = Uri.https(GlobalItems.hostLocation, '${GlobalItems.apiLocation}Coaches', queryParameters );
    else
      url = Uri.http(GlobalItems.hostLocation, '${GlobalItems.apiLocation}Coaches', queryParameters );

   print('---URI: ' + url.toString());
    //Await the http get response, then decode the json-formatted response.

    final response = await http.get(url, headers: {
      // io.HttpHeaders.authorizationHeader: 'Token $token',
      io.HttpHeaders.contentTypeHeader: 'application/json',
    });
    print('Response Status: ' + response.statusCode.toString());
    List<Coach> itemList = [];

    if (response.statusCode == 200) {
      print('--- HERE 1');
      Map jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      // var itemCount = jsonResponse['totalItems'];

      print('JSON Coach Payload: ' + jsonResponse.toString());

      List<dynamic> listItems = jsonResponse['items'];

   //  TEST List<Coach> listItems = Coach().getCoaches('filter');
    //      return listItems;
      for(int index = 0; index < listItems.length; index++) {

        Coach item = Coach();

        item.coachId=listItems[index]["CoachId"];
        item.coachName=listItems[index]["CoachName"];
        item.title=listItems[index]["Title"];
        item.profile=listItems[index]["Profile"];
        item.coachImageName=listItems[index]["CoachImageName"];

        var formatter = NumberFormat.decimalPattern('en-US');
        itemList.add(item);
        print('---');
      }
      return itemList;
    } else {
      print('Coach Response ERROR');
      print('Coach Request failed with status: ${response.statusCode}.');
      return itemList;
    }
  }

  Future<Coach> getCoach(int coachId)  async {

    final queryParameters = {
      // 'userId': User.userId.toString(),
      // 'api_key': User.apiKey,
      //'param2': 'two',
    };

    //var url ;
    //if (GlobalItems.prodServer)
      //var url = Uri.https('d1.allproview.com.au:8443', '/apvdemo/api/v1/Projects/70', queryParameters);
    // var url = Uri.https(GlobalItems.hostLocation, '${GlobalItems.apiLocation}Projects/$projectId', queryParameters );
    //
    // print('---Get Project URI: ' + url.toString());
    // // Await the http get response, then decode the json-formatted response.
    //
    // final response = await http.get(url, headers: {
    //   // io.HttpHeaders.authorizationHeader: 'Token $token',
    //   io.HttpHeaders.contentTypeHeader: 'application/json',
    // });
    // print('Response Status: ' + response.statusCode.toString());
    //
    // Project proj = Project();
    //
    // if (response.statusCode == 200) {
    //
    //   Map jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    //
    //   // var itemCount = jsonResponse['totalItems'];
    //   // print('Number of books about http: $itemCount.');
    //   print('JSON Payload: ' + jsonResponse.toString());
    //
    //   Map<String,dynamic> listItems = jsonResponse['project'];
    //
    //   print('--- HERE 2');
    //
    //   proj.tracking=listItems["Tracking"];
    //   // 23-03-1999
    //   String day = listItems["StartDate"].toString().substring(0,2);
    //   String mth = listItems["StartDate"].toString().substring(3,5);
    //   String year = listItems["StartDate"].toString().substring(6,10);
    //   proj.startDate=DateFormat('dd/MM/yyyy').format(DateTime.parse(year+'-'+mth+'-'+day));
    //   day = listItems["EndDate"].toString().substring(0,2);
    //   mth = listItems["EndDate"].toString().substring(3,5);
    //   year = listItems["EndDate"].toString().substring(6,10);
    //   proj.endDate=DateFormat('dd/MM/yyyy').format(DateTime.parse(year+'-'+mth+'-'+day));
    //   proj.manager=listItems["Manager"];
    //   proj.stage=listItems["Stage"];
    //   proj.reference=listItems["Reference"];
    //   proj.desc=listItems["Desc"]; // Title
    //   print(listItems["Desc"]);
    //
    //   proj.projectId=listItems["ProjectId"];
    //   proj.tec=Decimal.parse(listItems["TECRaw"].toString());
    //   //proj.tec=listItems["TEC"];
    //   //proj.tec=(Decimal)listItems["TEC"];
    //   var formatter = NumberFormat.decimalPattern('en-US');
    //   proj.tecFormatted=formatter.format(DecimalIntl(proj.tec));
    //
    //   proj.status=listItems["Status"];
    //   if (listItems["Classification"] != null)
    //     proj.classification=listItems["Classification"];
    //   if (listItems["ClientEMail"] != null)
    //     proj.contactEmail=listItems["ClientEMail"];
    //   if (listItems["ClientDOB"] != null)
    //     proj.clientDOB=listItems["ClientDOB"];
    //   if (listItems["ClientContactNo"] != null)
    //     proj.contactNo=listItems["ClientContactNo"];
    //   if (listItems["StreetNo"] != null)
    //     proj.streetNo=listItems["StreetNo"];
    //   if (listItems["StreetName1"] != null)
    //     proj.streetName1=listItems["StreetName1"];
    //   if (listItems["StreetName2"] != null)
    //     proj.streetName2=listItems["StreetName2"];
    //   if (listItems["Suburb"] != null)
    //     proj.suburb=listItems["Suburb"];
    //
    //   print('---Data');
    //
    //   if (listItems["StateId"] != null)
    //     proj.state=listItems["StateId"].toString();
    //   if (listItems["ServiceStateId"] != null)
    //     proj.servicingState=listItems["ServiceStateId"].toString();
    //   if (listItems["ReferralMethodId"] != null)
    //     proj.referralMethod=listItems["ReferralMethodId"].toString();
    //
    //   if (listItems["Postcode"] != null)
    //     proj.postcode=listItems["Postcode"];
    //   if (listItems["Nominee"] != null)
    //     proj.nominee=listItems["Nominee"];
    //   if (listItems["KeyInit"] != null)
    //     proj.isHighRisk=listItems["KeyInit"];
    //   if (listItems["NDISNumber"] != null)
    //     proj.nDISNumber=listItems["NDISNumber"];
    //   if (listItems["Overview"] != null)
    //     proj.disabilityDetails=listItems["Overview"];
    //   if (listItems["MedicalInfo"] != null)
    //     proj.medicalInfo=listItems["MedicalInfo"];
    //   if (listItems["Objectives"] != null) {
    //     proj.objectives = listItems["Objectives"].replaceAll('</br>', '\n');
    //   }
    //   //proj.suburb=listItems["Portfolio"];
    //   print('---Complete');
    //
    //   return proj;
    // } else {
    //   print('Response ERROR');
    //   print('Request failed with status: ${response.statusCode}.');
    //   return proj;
    // }
  return Coach();
  }
}