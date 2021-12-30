import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class firebasehelper {
  static String username = "A";
  static CollectionReference<Map<String, dynamic>> userInst =
      FirebaseFirestore.instance.collection("users");
  static CollectionReference<Map<String, dynamic>> eventsInst =
      FirebaseFirestore.instance.collection("users");
  static Future<DocumentSnapshot<Map<String, dynamic>>> getEvents() async {
    DocumentSnapshot<Map<String, dynamic>> x =
        await FirebaseFirestore.instance.collection("users").doc("C").get();
    return x;
  }

  static void addEvent(String name, String details) {
    //Confirm after completion
  }
  static void removeEvent(String name) {
    //Confirm after remove
  }
  static void addRecord(String name, String details) async {
    String event = "Moscow Trip";
    String paid_by = "B";
    List<String> paid_for = ["A", "B", "C", "D"];
    List<String> paid_for1 = ["A", "B", "C", "D"];
    int amount = 40;
    String description = "Description";
    String category = "Food";
    double amount_due = amount / 4;
    //add just record
    FirebaseFirestore.instance
        .collection("events")
        .doc(event)
        .collection("records")
        .add({
      "paid_by": paid_by,
      "paid_for": paid_for,
      "amount": amount,
      "amount_due": amount_due,
      "description": description,
      "category": category,
      // "date_time": Timestamp
    });
    //calc and divide amount
    double peramount = amount / paid_for.length;
    //get the current balance state
    DocumentSnapshot<Map<String, dynamic>> ref = await FirebaseFirestore
        .instance
        .collection("events")
        .doc(event)
        .collection("userData")
        .doc(paid_by)
        .get();
    //loop for paid by user Data edit
    for (String n in paid_for) {
      if (paid_by == n) {
        print(paid_by + " " + n);
        continue;
      }
      //get the old array data
      double toTake = 0;
      try {
        toTake = double.parse(ref.get(n)[1].toString());
        double temp = double.parse(ref.get(n)[0].toString());
        print("Good " + toTake.toString());
        toTake += amount_due;
        //write back the changed transact
        FirebaseFirestore.instance
            .collection("events")
            .doc(event)
            .collection("userData")
            .doc(paid_by)
            .update({
          n: [temp, toTake],
        });
      } catch (e) {
        //probably missing record so we create
        FirebaseFirestore.instance
            .collection("events")
            .doc(event)
            .collection("userData")
            .doc(paid_by)
            .update({
          n: [0, amount_due],
        });
        toTake = 0;
      }
    }
    //=====loop to change the paid for records
    for (String n in paid_for) {
      print("Vendores " + paid_for.length.toString());

      ref = await FirebaseFirestore.instance
          .collection("events")
          .doc(event)
          .collection("userData")
          .doc(n)
          .get();
      //get the old array data

      double toTake = 0;
      try {
        toTake = double.parse(ref.get(paid_by)[0].toString());
        double temp = double.parse(ref.get(paid_by)[1].toString());
        print("Good " + toTake.toString());
        toTake += amount_due;
        //write back the changed transact
        FirebaseFirestore.instance
            .collection("events")
            .doc(event)
            .collection("userData")
            .doc(n)
            .update({
          paid_by: [toTake, temp],
        });
      } catch (e) {
        //probably missing record so we create
        FirebaseFirestore.instance
            .collection("events")
            .doc(event)
            .collection("userData")
            .doc(n)
            .update({
          paid_by: [amount_due, 0],
        });
        toTake = 0;
      }
    }
  }

  static void reduceExpense() async {
    String paid_by = "B";
    String paid_to = "A";
    int amount = 5;
    String event = "Moscow Trip";
    DocumentSnapshot<Map<String, dynamic>> ref = await FirebaseFirestore
        .instance
        .collection("events")
        .doc(event)
        .collection("userData")
        .doc(paid_by)
        .get();
    int am = ref.data()![paid_to][0];
    int r = ref.data()![paid_to][1];
    am -= amount;
    //set new values ofr paid by
    FirebaseFirestore.instance
      ..collection("events")
          .doc(event)
          .collection("userData")
          .doc(paid_by)
          .update({
        paid_to: [am, r]
      });
    //====now for paid to
    ref = await FirebaseFirestore.instance
        .collection("events")
        .doc(event)
        .collection("userData")
        .doc(paid_to)
        .get();
    am = ref.data()![paid_by][1];
    r = ref.data()![paid_by][0];
    am -= amount;
    //set new values ofr paid by
    FirebaseFirestore.instance
      ..collection("events")
          .doc(event)
          .collection("userData")
          .doc(paid_to)
          .update({
        paid_by: [r, am]
      });
  }

  static void deleteRecord(String name, String path) {
    //confirm after delete
  }

  /*static Future<QuerySnapshot<Map<String, dynamic>>> queryRecords(
      String eventName) async {
     
  }*/
  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      String uname, String event) {
    uname = "A";
    event = "Moscow Trip";
    var x = FirebaseFirestore.instance
        .collection("events")
        .doc(event)
        .collection("userData")
        .doc(uname)
        .get();
    return x;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> queryTransactionStates(
      String eventName) async {
    //query about pending transaction amounts
    var x = await FirebaseFirestore.instance
        .collection("events")
        .doc("Moscow Trip")
        .collection("records")
        //.limit(2)
        .get();
    print((" Main count " + x.docs.length.toString()));
    return x;
  }

  static void getUserDetails() {
    //get user details
  }
}
