import 'package:decimal/decimal.dart';

// Helper class to pass around until payment confirmed
class Booking {

  int orgId = 0;
  int coachId=0;
  String productName='';
  String coachName='';
  String productTitle=''; // Returned from Server
  String productDateDisplay=''; // For Confirmation screen
  String productTimeDisplay=''; // For Confirmation screen
  int slot1=0;
  int slot2=0;
  dynamic slots =[];
  int learnerId=0;  // Learner.learnerId used ...
  String bookingDay=""; // ?
  Decimal bookingCharge= Decimal.parse('0.00');  // Returned from Server
  String formattedBookingCharge= '';

}
