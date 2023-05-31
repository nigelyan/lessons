import 'package:decimal/decimal.dart';

import '../global_items.dart';

class Coach {

  int coachId=0;
  String coachName="";
  String lastName="";
  String firstName="";
  String profile="";
  String title="";
  String coachImageName="";

  String startDate="";
  String endDate="";
  String stage="";
  String overview=""; // Title
  bool isHighRisk=false; // Using KeyInit
 // Decimal tec= Decimal.parse('0.00');
  String status="";
  String classification="";

  String streetName1="";
  String streetName2="";
  String streetNo="";
  String suburb="";
  String state="";
  String postcode="";
  String contactEmail="";
  String contactNo="";

  List<Coach> getCoaches(String filter) {

    Coach coach = Coach();

    List<Coach> dummyList = [];

    coach.coachId=1;
    coach.firstName="Jonathan";
    coach.lastName="Porter";
    coach.profile="Jonathan Porter burst onto the golfing scene in the early 90’s and turned "
        "professional by the age of 19.  He completed his traineeship at Huntingdale Golf Club "
        "winning 9 trainee tournaments along the way, playing alongside Scott Laycock "
        "(Previous Winner of Australian Order of Merit)." + '\n\n' + "Jonathan also won two Fosters "
        "Special Bitter Long Drive Tournaments before heading off overseas to run a Golf Academy and conduct golf "
        "lessons in Indonesia. On his return to Australia, he became the Head Professional for Troon Golf at "
        "Huntingdale Golf Club and then owned and managed his own Golf Academy at Sandringham Golf Academy.";
    coach.coachImageName='jPorter.png';
    coach.title="Head Coach";
    dummyList.add(coach);

    Coach coach2 = Coach();

    coach2.coachId=2;
    coach2.firstName="Brendan";
    coach2.lastName="Green";
    coach2.profile="Brendan has been a member of the PGA of Australia since 2003."  + '\n\n' +
    "He was a member at Victoria Golf Club and completed his PGA Traineeship at Heidelberg Golf Club. " +
    "He also assisted the Heidelberg Ladies Pennant Team in winning the Division 1 Pennant title.""";
    coach2.coachImageName='bGreen.png';
    coach2.title="Coach";
    dummyList.add(coach2);

    Coach coach3 = Coach();
    coach3.coachId=3;
    coach3.firstName="Tiger";
    coach3.lastName="Woods";
    coach3.profile="Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, "+
        "qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    coach3.coachImageName='jPorter.png';
    coach3.title="Assistant Coach";
    dummyList.add(coach3);

    Coach coach4 = Coach();
    coach4.coachId=4;
    coach4.firstName="Rory";
    coach4.lastName="McIlroy";
    coach4.profile="Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, "+
        "qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    coach4.coachImageName='jPorter.png';
    coach4.title="Assistant Coach";
    dummyList.add(coach4);

    return dummyList;
  }




//  Project(this.reference, this.firstName, this.lastName, this.isHighRisk);

}
