import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expenseapp/firebaseUtil/firebaseutilss.dart';

class eventlistscr extends StatefulWidget {
  eventscr createState() => eventscr();
}

class eventscr extends State<eventlistscr> {
  bool eventListReady = false;
  String txt = "a";
  List<Text> t = [Text("loading")];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("users").doc("C").get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        int x = 5;
        Map<String, dynamic> z;
        if (snapshot.hasData)
          return ListView(children: getListItems(snapshot));
        else
          return Text("Load");
      },
    );
  }

  List<Widget> getListItems(AsyncSnapshot<DocumentSnapshot> snapshot) {
    List<Widget>? lt = [Text("None")];
    for (var x in (snapshot.data!.data() as Map<String, dynamic>)["events"]) {
      lt.add(Text(x));
    }
    lt.removeAt(0);
    print(lt);
    return lt;
  }
}
