import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expenseapp/firebaseUtil/firebaseutilss.dart';
import 'package:flutter/rendering.dart';

class calcbalance extends StatefulWidget {
  @override
  balance createState() {
    return balance();
  }
}

class balance extends State<calcbalance> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebasehelper.getUserData("uname", "event"),
      builder: (builder,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          //print(snapshot.data!.get("B"));
          firebasehelper.addEvent("aa", "a");
          print("Sum " +
              getTotalToTake(snapshot.data!.data() as Map<String, dynamic>)
                  .toString());
          return Text("Done");
        } else
          return Text("loadd");
      },
    );
  }

  int getTotalToGive(Map<String, dynamic> x) {
    int sum = 0;
    for (var a in x.values) {
      sum += int.parse(a[0].toString()); //int.parse(a);
    }
    return sum;
  }

  int getTotalToTake(Map<String, dynamic> x) {
    int sum = 0;
    for (var a in x.values) {
      sum += int.parse(a[1].toString()); //int.parse(a);
    }
    return sum;
  }
}
