import 'dart:convert' as convert;
import 'dart:io' as io;
import 'package:golf_lessons/data/booking.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';

import '../data/coach.dart';
import '../global_items.dart';

class Slot {
 // DateTime slotDay=DateTime.now();
  bool slotAvailable= true;
  int slotSeq=0;
  int slotNo=0;
  String slotTitle='';

 // Slot(this.slotAvailable, this.slotSeq,this.slotNo, this.slotTitle);
}
