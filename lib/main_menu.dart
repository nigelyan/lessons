import 'package:flutter/material.dart';
import 'package:golf_lessons/ui/booking/samples/complex_example.dart';
import 'package:golf_lessons/ui/booking/booking_screen.dart';
import '../user.dart';
import 'package:golf_lessons/ui/booking/samples/coach_list_screen.dart';
import 'package:golf_lessons/ui/coach_list_screen_float.dart';
import 'package:golf_lessons/ui/booking/samples/basics_example.dart';
import 'package:golf_lessons/ui/learner_register_screen.dart';

void main() {
 // MaterialPageRoute(builder: (context) => ProjectList());
}
class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  @override
  Widget build(BuildContext context) {
    home:
   return Scaffold(
     // appBar: AppBar(
       // title: const Text('Verbinding'),
       // automaticallyImplyLeading: false,
      //),

      body: Center(

        child: ListView(
        children: <Widget>[
         Container(
         alignment: Alignment.center,
         padding: const EdgeInsets.all(10),
         child: const Text(
           'Main Menu',
           style: TextStyle(
               color: Colors.blue,
               fontWeight: FontWeight.w500,
               fontSize: 30),
           textAlign: TextAlign.center,
         )),
          Container(
              height: 75,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ElevatedButton(
                child: const Text('Our Golf Coaches'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CoachListScreenFloat()),
                  );
                },
              )
          ),
          Container(
              height: 75,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ElevatedButton(
                child: const Text('Our Lessons & Packages'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CoachListScreenFloat()),
                  );
                },
              )
          ),
          Container(
              height: 75,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ElevatedButton(
                child: const Text('Register'),
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => const LearnerRegister()),
                  );
                },
              )
          ),

        ]),
     ),
    );
  }}


