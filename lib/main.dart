import 'package:expenseapp/firebaseUtil/firebaseutilss.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebaseUtil/datamodel.dart';
import 'eventlistscreen.dart';
import 'records.dart';
import 'calc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String host = '192.168.1.117:8080';
  await Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //firestore.clearPersistence();
  firestore.useFirestoreEmulator('192.168.1.117', 8080, sslEnabled: false);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Call the user's CollectionReference to add a new user
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String txt = "Hello";
  @override
  Widget build(BuildContext context) {
    //sett();
    return Scaffold(
      appBar: AppBar(
        actions: [
          RaisedButton(
            onPressed: () {},
            child: Text("table reload"),
          )
        ],
        title: RaisedButton(
          onPressed: () {
            //dataModel.createDataModel();
            print("Event");
            //firebasehelper.addRecord("aa", "aa");
            //firebasehelper.reduceExpense();
            printNameTransaction();
          },
          child: /*eventlistscr()*/ Text("Create data model"),
        ),
      ),
      body: Text("Hello"),
    );
  }

  void printNameTransaction() async {
    String qUser = "A";
    DocumentSnapshot<Map<String, dynamic>> d = await FirebaseFirestore.instance
        .collection("events")
        .doc("Moscow Trip")
        .collection("userData")
        .doc(qUser)
        .get();
    Map<String, dynamic> m = d.data() as Map<String, dynamic>;
    print(qUser + " data:");
    for (String val in m.keys) {
      print(qUser + " will give " + m[val][0].toString() + " to " + val);
      print(qUser + " will take " + m[val][1].toString() + " from " + val);
    }
  }

  Future<void> sett() async {
    var x = await firebasehelper.getEvents();
    setState(() {
      txt = x[0];
      print(x[0]);
    });
  }
}
