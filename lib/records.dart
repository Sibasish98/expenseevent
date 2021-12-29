import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expenseapp/firebaseUtil/firebaseutilss.dart';
import 'package:flutter/rendering.dart';

class recordView extends StatefulWidget {
  @override
  recordsView createState() {
    return recordsView();
  }
}

class recordsView extends State<recordView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebasehelper.queryTransactionStates("Moscow Trip"),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            //return Text(snapshot.data!.docs[0].get("description"));
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text("Paid By")),
                        DataColumn(label: Text("Paid For")),
                        DataColumn(label: Text("Amount")),
                        DataColumn(label: Text("Description")),
                        DataColumn(label: Text("Category"))
                      ],
                      rows: buildRecord(snapshot),
                    )));
          } else
            return Text("load");
        });
  }

  List<DataRow> buildRecord(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> records =
        snapshot.data!.docs;
    List<DataRow> z = [];
    // print(records[0]["paid_for"]);
    //print(records[1]["paid_for"]);
    //print(records[2]["paid_for"]);
    int i = 1;
    print("Count " + records.length.toString());
    for (var x in records) {
      i++;
      z.add(DataRow(cells: [
        DataCell(Text(x["paid_by"])),
        DataCell(Text(getpaidbystring(x["paid_for"]))),
        DataCell(Text(x["amount"].toString())),
        DataCell(Text(x["description"])),
        DataCell(Text(x["category"]))
      ]));
    }
    return z;
  }

  String getpaidbystring(var x) {
    String n = "";
    for (String z in x) {
      n += z + ",";
    }
    return n.substring(0, n.length - 1);
  }
}
