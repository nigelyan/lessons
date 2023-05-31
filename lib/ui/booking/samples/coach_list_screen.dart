import 'package:flutter/material.dart';
import 'package:float_column/float_column.dart';
//import 'package:vbind/ui/client_menu.dart';

import '../../../data/coach.dart';
import '../../../global_items.dart';
import '../../../services/coach_data_access.dart';
import '../booking_screen.dart';
import '../../../user.dart';

class CoachListScreen extends StatefulWidget {
  const CoachListScreen({Key? key}) : super(key: key);

  @override
  _CoachListScreen createState() => _CoachListScreen();
}

class _CoachListScreen extends State<CoachListScreen> {

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
      //print('Coach Name: '+ coach.co);

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

                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 20.0),

                                  alignment: Alignment.topLeft,
                                  height: 50.0,
                                  child: Image.network(
                                   // GlobalItems.imageLocation + 'jPorter.png',
                                   // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                                    'https://d1.allproview.com.au:8443/ndconnect/' + coaches[index].coachImageName,
                                    fit: BoxFit.cover,
                                  ),
                                 ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: ListTile(

                                    trailing: Icon(Icons.favorite_outline),
                                    title: Text(coaches[index].coachName +
                                        ' - ' + coaches[index].title
                                    ),
                                    subtitle: Text(coaches[index].profile ),
                                  ),
                                ),







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
                                      MaterialPageRoute(builder: (context) => BookingScreen()),
                                    );
                                    },
                                  )
                                ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ),
                //),
              ]),
        ));
  }

  void main(List<String> arguments) async {
  }
}