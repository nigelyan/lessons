import 'dart:convert' as convert;
import 'dart:io' as io;
import 'package:golf_lessons/data/booking.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';

import '../data/booking_slot.dart';
import '../data/coach.dart';
import '../data/learner.dart';
import '../global_items.dart';
import '../user.dart';

class BookingService
{
  //
  //
  //
  Future<List<Slot>> getBookableSlots(int orgId, int coachId, String bookingDay)  async {

    final queryParameters = {
       'userId': User.userId.toString(),
       'api_key': User.apiKey,
       'orgId':orgId.toString(),
       'coachId': coachId.toString(),
       'bookingDay': bookingDay
    };
    //http://localhost:8080/lessons/api/v1/Slots?userId=1&api_key=fred&bookingYear=2023-05-01&coachId=1&orgId=1
    var url ;
    if (GlobalItems.prodServer)
      url = Uri.https(GlobalItems.hostLocation, '${GlobalItems.apiLocation}Slots', queryParameters );
    else
      url = Uri.http(GlobalItems.hostLocation, '${GlobalItems.apiLocation}Slots', queryParameters );

    print('---URI: ' + url.toString());
    // Await the http get response, then decode the json-formatted response.

    final response = await http.get(url, headers: {
      // io.HttpHeaders.authorizationHeader: 'Token $token',
      io.HttpHeaders.contentTypeHeader: 'application/json',
    });
    print('Response Status: ' + response.statusCode.toString());
    List<Slot> slotList = [];

    if (response.statusCode == 200) {
      print('--- HERE 1');
      Map jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      // var itemCount = jsonResponse['totalItems'];

      print('JSON Slots Payload: ' + jsonResponse.toString());

      List<dynamic> listItems = jsonResponse['items'];

     for(int index = 0; index < listItems.length; index++) {

        Slot item = Slot();

        item.slotAvailable=true; // for now..
        item.slotNo=listItems[index]["SlotNo"];
        item.slotSeq=listItems[index]["SlotSeq"];
        item.slotTitle=listItems[index]["SlotTitle"];
      //  proj.startDate=DateFormat('dd/MM/yyyy').format(DateTime.parse(listItems[index]["StartDate"]));

        slotList.add(item);
        print('---');
      }
      return slotList;
    } else {
      print('Slots Response ERROR');
      print('Slots Request failed with status: ${response.statusCode}.');
      return slotList;
    }
  }

  //
  //
  //
  Future<dynamic> getBookingCharge( String? productName)  async {

    final queryParameters = {
       'userId': User.userId.toString(),
       'api_key': User.apiKey,
       'orgId':User.orgId.toString(),
       'productName': productName

    };

    var url ;
    if (GlobalItems.prodServer)
      url = Uri.https(GlobalItems.hostLocation, '${GlobalItems.apiLocation}Booking/Charge', queryParameters );
    else
      url = Uri.http(GlobalItems.hostLocation, '${GlobalItems.apiLocation}Booking/Charge', queryParameters );

    print('---Get Product Charge: ' + url.toString());
    // Await the http get response, then decode the json-formatted response.

    final response = await http.get(url, headers: {
      // io.HttpHeaders.authorizationHeader: 'Token $token',
      io.HttpHeaders.contentTypeHeader: 'application/json',
    });
    print('Response Status: ' + response.statusCode.toString());

    if (response.statusCode == 200) {

      Map jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

      // var itemCount = jsonResponse['totalItems'];
      // print('Number of books about http: $itemCount.');
      print('JSON Payload: ' + jsonResponse.toString());

      Map<String,dynamic> listItems = jsonResponse['items'];

      print('--- HERE 2');

      dynamic temp=Decimal.parse(listItems["Charge"].toString());
      var formatter = NumberFormat.simpleCurrency(locale: 'en-US', decimalDigits: 2);
      //return formatter.format(DecimalIntl(temp));

      Booking booking = Booking();
      booking.bookingCharge=temp;
      booking.formattedBookingCharge=formatter.format(DecimalIntl(temp));
      booking.productTitle=listItems["ProductTitle"];

      return booking;
    } else {
      print('----Response ERROR');
      print('----Request failed with status: ${response.statusCode}.');
      return 0;
    }
    return null;
  }
  //
  //
  //
  Future<bool> addBooking(Booking booking) async
  {
    // https://d1.allproview.com.au:8443/apvdemo/api/v1/Projects/70
    print('---Add Booking, Day:' + booking.bookingDay);
    print('---Add Booking, Coach Id:' + booking.coachId.toString());
    print('---Add Booking, Charge:' + booking.bookingCharge.toString());
    print('---Add Booking, Learner Id:' + Learner.learnerId.toString());
    print('---Add Booking, SlotId:' + booking.slot1.toString());
    print('---Add Booking, Org:' + User.orgId.toString());
    var url ;
    if (GlobalItems.prodServer)
      url = Uri.https(GlobalItems.hostLocation, '${GlobalItems.apiLocation}Bookings');
    else
      url = Uri.http(GlobalItems.hostLocation, '${GlobalItems.apiLocation}Bookings');

    // Await the http get response, then decode the json-formatted response.
    // print('$userId-$password');
    final response = await http.post(url, headers: <String, String>{
      io.HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: convert.jsonEncode(<String, String>{
          'OrgId': User.orgId.toString(),
          'BookingDay': booking.bookingDay,
          'CoachId': booking.coachId.toString(),
          'LearnerId': Learner.learnerId.toString(),
          'SlotNo': booking.slot1.toString(),
          'SlotNo2': booking.slot2.toString(),
          'Charge': booking.bookingCharge.toString()
      }));
      print ('---HTTP Status Add Booking: ' + response.statusCode.toString());
        if (response.statusCode == 200) {
          var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
          // var itemCount = jsonResponse['totalItems'];
          print('Added Booking successfully');

          String data = response.body;
          //print(data);
          //var decodedData = jsonDecode(data);

          print(jsonResponse);
         // User.apiKey=jsonResponse['api_key'];
          //User.userId=jsonResponse['userId'];
          return true;
        } else {
      print('Response ERROR');
      print('Request failed with status: ${response.statusCode}.');

      return false;
    }
  }

}


