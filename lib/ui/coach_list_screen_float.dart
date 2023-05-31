import 'package:flutter/material.dart';
import 'package:float_column/float_column.dart';
//import 'package:vbind/ui/client_menu.dart';

import '../data/coach.dart';
import '../global_items.dart';
import '../services/coach_data_access.dart';
import '../user.dart';
import '../ui/booking/booking_screen.dart';

class CoachListScreenFloat extends StatefulWidget {
  const CoachListScreenFloat({Key? key}) : super(key: key);

  @override
  _CoachListScreenFloat createState() => _CoachListScreenFloat();
}

class _CoachListScreenFloat extends State<CoachListScreenFloat> {

  List<Coach> coaches =[];
  bool gettingData =true;  // Used to display progress bar
  int ctr=0;

  Future<dynamic> getCoachList() async
  {
    CoachService service = CoachService();

    List fred = await service.getCoaches(User.orgId);

    coaches.clear();

    for (var i = 0; i < fred.length; i++) {
      var coach = fred[i];
      coaches.add(coach);
      print('Coach Id: '+ coach.coachId.toString());
      print('Coach Name: '+ coach.lastName);

    }
    setState(() {    gettingData=false;});
  }

  Future refresh() async{
    setState(() {
      getCoachList();
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctr++;  // Use to ensure Build is only performed once ...on setState()

    if (ctr==1) {
      getCoachList().then((value) =>
          setState(() {
            print('---In setState in Build after fetch...');
          }));
    }
    return Scaffold(
      // Add button for future use...
      //   floatingActionButton: FloatingActionButton(
      //       hoverElevation: 50,
      //       hoverColor: Colors.orange,
      //       highlightElevation: 50,
      //       onPressed: null,
      //       child: Icon(Icons.add)
      //   ),
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title:  const Text('JP Golf - Our Coaches'),
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
                      :ListView.builder(
                      itemCount: coaches.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 4.0),

                          child: Card(

                              child:FloatColumn(
                                children:  [
                                  Floatable(
                                    float: FCFloat.start,
                                    maxWidthPercentage: 0.25,
                                    padding: EdgeInsetsDirectional.only(top: 10, start:5, end: 12),
                                    child: Image.network(
                                      GlobalItems.prodServer? 'https://d1.allproview.com.au:8443/lessons/' + coaches[index].coachImageName
                                      : 'https://d1.allproview.com.au:8443/lessons/' + coaches[index].coachImageName,
                                      fit: BoxFit.cover,
                                    ),

                                    // child: FlutterLogo(size: 100),
                                  ),
                                  WrappableText(
                                      text: TextSpan(
                                          text: coaches[index].coachName ,
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                                  WrappableText(
                                      text: TextSpan(
                                          text: coaches[index].title,
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                                  WrappableText(
                                      text: TextSpan(
                                          text: coaches[index].profile)),
                                  ButtonBar(
                                    children: [
                                      TextButton(
                                        child: const Text('REVIEWS'),
                                        onPressed: () {/* ... */},
                                      ),
                                      TextButton(
                                        child: const Text('BOOK A LESSON'),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => BookingScreen(),
                                                settings: RouteSettings(
                                                arguments: coaches[index],
                                              ),
                                            ),
                                          );

                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),                         ),
                        );
                      }
                  ),
                ),
                //),
              ]),
        ));
  }

  void main(List<String> arguments) async {
    List<Coach> coaches = getCoachList() as List<Coach>;
    print('--- Finished');
  }
}