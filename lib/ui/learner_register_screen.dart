import 'package:flutter/material.dart';

import '../data/learner.dart';
import '../main_menu.dart';
import '../services/user_data_access.dart';
import '../user.dart';

class LearnerRegister extends StatefulWidget {
  const LearnerRegister({Key? key}) : super(key: key);

  @override
  State<LearnerRegister> createState() => _LearnerRegisterState();
}

class _LearnerRegisterState extends State<LearnerRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  void forgotPassword()
  {
    print('running forgot pass');
  }
  void processRegistration() async {
    if(User.userId <= 0)print('Usr Id <=0');
    print('running login');
    print('UserEmail: ' +emailController.text);
    //print('Password: ' + passwordController.text);
    UserLogin userLogin = UserLogin();

    await userLogin.learnerRegister(emailController.text, contactNoController.text, firstNameController.text, lastNameController.text);

    if(Learner.learnerId > 0)
    {
      print ('Registration Success');

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registration'),
            content: const Text('Success! - Continue with Booking...'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK')),
            ],
          ));


      //print(User.userId.toString());
     // print(User.apiKey);
     //  Navigator.push(
     //    context,
     //    MaterialPageRoute(builder: (context) => const MainMenu()),
     //  );
    }
    else
    {
      print('Registration Failed');
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registration Problem!'),
            content: const Text('Failed'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK')),
            ],
          ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text('Golf Lessons - Learner Registration')),
    // body: const ui.MyStatefulWidget(),
    // body: proj.ProjectList(),
    // ),
    body:
    Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            // Container(
            //     alignment: Alignment.center,
            //     padding: const EdgeInsets.all(10),
            //     // child: const Text(' ',
            //     // //  'ACME Golf Lessons',
            //     //   style: TextStyle(
            //     //       color: Colors.blue,
            //     //       fontWeight: FontWeight.w500,
            //     //       fontSize: 30),
            //     //   textAlign: TextAlign.center,
            //     // )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'eMail',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: contactNoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact No:',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () {
                    processRegistration();
                    /*
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('Login'),
                              content: const Text('Login Details incorrect'),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK')),
                              ],
                            ));

                     */
                    print('clicked..');
                    print(emailController.text);
                    //print(passwordController.text);
                  },
                )),
//             TextButton(
//               onPressed: () {
//                 this.forgotPassword();
//               },
// /*                showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                           title: const Text('Login'),
//                           content: const Text('Not implemented yet!'),
//                           actions: [
//                             TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: Text('OK')),
//                           ],
//                         ));
//               },
//
//  */
//               // child: const Text(
//               //   'Forgot Password',
//               // ),
//             ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     const Text('Does not have account?'),
            //     TextButton(
            //       child: const Text(
            //         'Sign in',
            //         style: TextStyle(fontSize: 20),
            //       ),
            //       onPressed: () {
            //         //signup screen
            //       },
            //     )
            //   ],
            // ),
          ],
        ))
    );

  }
}
