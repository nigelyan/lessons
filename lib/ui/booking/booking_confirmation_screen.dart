import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:float_column/float_column.dart';
import 'package:golf_lessons/data/booking.dart';
//import 'package:vbind/ui/client_menu.dart';

import '../../services/booking_data_access.dart';
import '../../global_items.dart';
import 'package:golf_lessons/user.dart';
import 'package:golf_lessons/data/booking.dart';

class BookingConfirmation extends StatefulWidget {
  const BookingConfirmation({Key? key}) : super(key: key);

  @override
  _BookingConfirmation createState() => _BookingConfirmation();
}

class _BookingConfirmation extends State<BookingConfirmation> {

  bool gettingData =true;  // Used to display progress bar
  int ctr=0;
  dynamic bookingCharge = 0;
  Booking passedInBooking = Booking() ;
  Booking bookingForConfirmation= Booking();

  //
  //  Add Booking to DB and forward to payment gateway...
  //
  void processBooking() async {
    BookingService service = BookingService();

    passedInBooking.bookingCharge=bookingForConfirmation.bookingCharge;

    service.addBooking(passedInBooking);
  }

  // Derive booking charge
  Future<void> getBookingCharge(String productName) async
  {
    BookingService service = BookingService();

    // Returns a product Title for user display and the Charge
    // Taxes and Total Charge TBD
    bookingForConfirmation = await service.getBookingCharge(productName);

    //return
    setState(() {    gettingData=false;});
  }

  Future refresh() async{
    setState(() {
     // getCoachList();
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctr++;  // Use to ensure Build is only performed once ...on setState()
    passedInBooking = ModalRoute.of(context)!.settings.arguments as Booking;
    print('---Confirmation Coach: ' +passedInBooking.coachName);
    print(passedInBooking.coachId.toString());
    print('---Slot1: ' +passedInBooking.slot1.toString());
    print('---Slot2: ' +passedInBooking.slot2.toString());
    if (ctr==1) {
      // Get Charge & Product Title for User display..
      getBookingCharge( passedInBooking.productName);

    }
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title:  const Text('Booking Confirmation'),
          centerTitle: true,
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            refresh();
          },
          child: Column(
              children: <Widget>[
                Expanded(
                  child: gettingData
                      ?
                  Transform.scale(
                    scale: 0.1,
                    child: LinearProgressIndicator(),
                  )
                      :ListView(
                        children: <Widget>[
                          Padding( padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 14.0),
                            child:Table(
                                border: TableBorder.symmetric(), //table border
                                children: [
                                  TableRow(
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                      children: [
                                        TableCell(child: Text('')),
                                        TableCell(child: Text('')),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        TableCell(child: Text("Coach:",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        )),
                                        TableCell(child: Text(passedInBooking.coachName,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        )),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        TableCell(child: Text("Details:",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        )),
                                       TableCell(child: Text(bookingForConfirmation.productTitle,
                                         style: TextStyle(
                                           fontSize: 20,
                                         ),
                                       )),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        TableCell(child: Text("Date:",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        )),
                                        TableCell(child: Text(passedInBooking.productDateDisplay,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        )),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        TableCell(child: Text("Time:",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        )),
                                        TableCell(child: Text(passedInBooking.productTimeDisplay,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        )),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        TableCell(child: Text("Charge:",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        )),
                                        TableCell(child: Text(bookingForConfirmation.formattedBookingCharge,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        )),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        TableCell(child: Text('',
                                        style: TextStyle(
                                          fontSize: 20
                                        ) )),
                                        TableCell(child: Text('')),
                                      ]
                                  ),
                                  TableRow(
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,

                                      ),
                                      children: [
                                        TableCell(child: Text("Total Payable:",
                                          style: TextStyle(
                                            fontSize: 30,
                                              color: Colors.black54
                                          ),
                                        )),
                                        TableCell(child: Text(bookingForConfirmation.formattedBookingCharge,
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black54
                                          ),
                                        )),
                                      ]
                                  ),

                                ]
                            )
                        ),
                          Container(
                              height: 70,
                              width: 300,
                              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: ElevatedButton(
                                child: const Text('Proceed to Payment'),
                                // Add booking and proceed to payment screen
                                onPressed: () {
                                   print('--- clicked Confirm..');
                                   processBooking();
                                 },
                              )),
                        ] //}
                  ),
                ),

              ]),
        ));
  }

  void main(List<String> arguments) async {
   // List<Coach> coaches = getCoachList() as List<Coach>;
    print('--- Finished');
  }
}