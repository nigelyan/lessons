import 'package:flutter/material.dart';
import 'package:golf_lessons/data/learner.dart';
import 'package:golf_lessons/global_items.dart';
import 'package:golf_lessons/services/booking_data_access.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/booking.dart';
import '../../data/booking_slot.dart';
import '../../data/coach.dart';
import '../../data/product.dart';
import '../../user.dart';
import '../learner_register_screen.dart';
import 'booking_confirmation_screen.dart';
import 'utils.dart';

class Event {
  final String title;
  bool isAvailable=true;
  int slotNo;
  Event(this.title, this.isAvailable, this.slotNo);

  @override
  String toString() => title;
}

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
 // late final ValueNotifier<List<Event>> _selectedEvents ;
  ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart ;
  DateTime? _rangeEnd;

  Coach passedInCoach = Coach();
  Booking bookingHelper = Booking();
  var selectedIndexes = [];
  var selectedSlotNo = [];
  var selectedSlotTitle = [];

  int ctr=0;

   @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  // Get fixed No of Slots minus those that have been booked for a Day
  Future <List<Event>> _getEventsForDay(DateTime day) async {
    // Implementation example
   var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(day);
    print('---In getEventsForDay: ' + formattedDate);

    List<Event> eventList = [];

    BookingService bookService = BookingService();

    List<Slot> slots = await bookService.getBookableSlots(User.orgId, passedInCoach.coachId, formattedDate);

    // Map Slots to Events
    for (var i = 0; i < slots.length; i++) {
      var slot = slots[i];

      eventList.add(Event(slot.slotTitle, true, slot.slotNo));
    }
   // _selectedEvents = ValueNotifier(eventList);
   // _selectedEvents.value = eventList;

   // return kEvents[day] ?? [];
    return eventList;
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example

    final days = daysInRange(start, end);

    return [
      //for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async{
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        selectedIndexes.clear();
        selectedSlotNo.clear();
        selectedSlotTitle.clear();
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = await _getEventsForDay(selectedDay);
    }
  }

  // Not using Ranges [NY]
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });

    // `start` or `end` could be null
    // if (start != null && end != null) {
    //   _selectedEvents.value = _getEventsForRange(start, end);
    // } else if (start != null) {
    //   _selectedEvents.value = _getEventsForDay(start);
    // } else if (end != null) {
    //   _selectedEvents.value = _getEventsForDay(end);
    // }
  }

  Future<dynamic>  test() async{
    // _selectedDay = _focusedDay;
    //_getEventsForDay(_selectedDay!);
    _selectedDay = DateTime.now();

    _selectedEvents= ValueNotifier( await _getEventsForDay(_selectedDay!));

  }
  @override
  void initState() {
    super.initState();

    // _selectedDay = _focusedDay;
  //   _selectedDay = DateTime.now();
     print('---In  initState 1');
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    // Call test as calling an async function directly from init() is verboten

  //  setState(() {test();
  //  print('---In  initState - setstate');

  //  });
    print('---In  initState - after setstate');
    // _selectedEvents = ValueNotifier(_getEventsForDay);
  }

  @override
  Widget build(BuildContext context) {
    passedInCoach = ModalRoute.of(context)!.settings.arguments as Coach;

    ctr++;
    if (ctr==1) {
      test ().then((value) => setState(() {
        print('---In setState in Build after fetch...');
      }));

    }


      return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          hoverElevation: 40,
          hoverColor: Colors.orange,
          backgroundColor: Colors.deepPurpleAccent,
          highlightElevation: 40,
          label: Text('Book'),

          onPressed: (){
            if (selectedSlotNo.isEmpty) {
              return;
            }
            // Proceed to confirmation - check User registration first etc...
            if (Learner.learnerId==0)  {
              print('---LearnerId is 0');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LearnerRegister(),
                    settings: RouteSettings(
                      //arguments: bookingHelper,
                    ),
                  ),
                );
                return;
            }
            print('---Pressed Book:');
            print ('Slots Selected:' + selectedSlotNo.toString());
            print ('Events Selected:' + _selectedEvents.toString());
            print ('BookingDay:' +_selectedDay.toString());
            print ('Coach:' +passedInCoach.coachName);
            print ('Coach Id:' +passedInCoach.coachId.toString());

            bookingHelper.slots=selectedSlotNo;
            bookingHelper.coachId = passedInCoach.coachId;
            bookingHelper.coachName=passedInCoach.coachName;
            bookingHelper.bookingDay = _selectedDay.toString().substring(0,10);
            String temp=DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedDay.toString())) ;
            bookingHelper.productDateDisplay=temp;
            bookingHelper.productTimeDisplay=  selectedSlotTitle[0];

            if (selectedSlotNo.length == 1)
            {
              bookingHelper.slot1=selectedSlotNo[0];
              bookingHelper.productName = Product.singleSlot;
            }
            else {
              bookingHelper.slot1=selectedSlotNo[0];
              bookingHelper.slot2=selectedSlotNo[1];
              bookingHelper.productName = Product.doubleSlot;
            }

            // Proceed to confirmation - check User registration first etc...
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BookingConfirmation(),
                settings: RouteSettings(
                  arguments: bookingHelper,
                ),
              ),
            );

          },
          //icon: Icon(Icons.add)
      ),

      appBar: AppBar(
        title: Text( passedInCoach.coachName + ' - Available Bookings',
        style: TextStyle(
            fontSize: 16,
        ),),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay:  kFirstDay,

            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
          //  eventLoader: _getEventsForDay,  // NY Commented out
            startingDayOfWeek: StartingDayOfWeek.monday,

            // Use `CalendarStyle` to customize the UI
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              markerDecoration: const BoxDecoration( color: Colors.blue, shape: BoxShape.circle, ),
              markersMaxCount: 0,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
              child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 50,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                          //textDirectionToAxisDirection(textDirection)
                        ),
                        child: CheckboxListTile(
                          dense: true,
                          //tristate: true,
                          tileColor: Colors.lightBlue[200],
                          value: selectedIndexes.contains(index),
                          title: Text('${value[index].title}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                    fontSize: 18
                                ),
                          ),
                          onChanged: (_) {
                            if (selectedIndexes.contains(index)) {
                              selectedIndexes.remove(index);
                              selectedSlotNo.remove(value[index].slotNo);// unselect
                              selectedSlotTitle.remove(value[index].title);// unselect
                            } else {
                              selectedIndexes.add(index);  // select
                              selectedSlotNo.add(value[index].slotNo);// unselect
                              selectedSlotTitle.add(value[index].title);// unselect
                              print('Slot: ${value[index].slotNo}');
                            }
                            print('---Index: ' + selectedIndexes.toString());
                            print('---Slot: ' + selectedSlotNo.toString());
                            print('---Title: ' + selectedSlotTitle.toString());
                            setState(() {
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}