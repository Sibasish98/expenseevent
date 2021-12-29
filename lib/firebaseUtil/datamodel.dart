import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class dataModel {
  static List<String> users = ["A", "B", "C", "D"];
  static List<String> events = ["Moscow Trip"];
  static void createDataModel() async {
    //First create 4 users (A,B,C,D)
    FirebaseFirestore.instance
        .collection("users")
        .doc(users[0])
        .set({"Name": users[0]});
    FirebaseFirestore.instance
        .collection("users")
        .doc(users[1])
        .set({"Name": users[1]});
    FirebaseFirestore.instance
        .collection("users")
        .doc(users[2])
        .set({"Name": users[2]});
    FirebaseFirestore.instance
        .collection("users")
        .doc(users[3])
        .set({"Name": users[3]});
    //Document reference varibale for users
    List<DocumentReference> usersDoc = [
      FirebaseFirestore.instance.collection("users").doc(users[0]),
      FirebaseFirestore.instance.collection("users").doc(users[1]),
      FirebaseFirestore.instance.collection("users").doc(users[2]),
      FirebaseFirestore.instance.collection("users").doc(users[3])
    ];
    //Add events
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .set({"Name": events[0]});
    //Add reference of events in respecive user's
    FirebaseFirestore.instance.collection("users").doc(users[0]).set({
      "events": [events[0]]
    }, SetOptions(merge: true));
    FirebaseFirestore.instance.collection("users").doc(users[1]).set({
      "events": [events[0]]
    }, SetOptions(merge: true));
    FirebaseFirestore.instance.collection("users").doc(users[2]).set({
      "events": [events[0]]
    }, SetOptions(merge: true));
    FirebaseFirestore.instance.collection("users").doc(users[3]).set({
      "events": [events[0]]
    }, SetOptions(merge: true));
    //Add user reference in events
    FirebaseFirestore.instance.collection("events").doc(events[0]).set({
      "participant": [
        users[0],
        users[1],
        users[2],
        users[3],
      ]
    }, SetOptions(merge: true));
    //add userdata in the event which has record of who gets what transaction pending
    /*FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[0])
        .set({
      users[0]: [10,0],
      users[1]: [0, 0],
      users[2]: [0, 0],
      users[3]: [0, 0],
    });
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[1])
        .set({
      users[0]: [0, 0],
      users[1]: [10,0],
      users[2]: [0, 0],
      users[3]: [0, 0],
    });
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[2])
        .set({
      users[0]: [0, 0],
      users[1]: [0, 0],
      users[2]: [0,0],
      users[3]: [0, 0],
    });
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[3])
        .set({
      users[0]: [0, 0],
      users[1]: [0, 0],
      users[2]: [0, 0],
      users[3]: [5,0],
    });*/
    //Add 4 records
    // => Record 1
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("records")
        .add({
      "paid_by": users[0],
      "paid_for": [users[0], users[1], users[2], users[3]],
      "amount": 40,
      "amount_due": 10,
      "category": "Lunch",
      "description": "Test Spicy Lunch",
      "date_time": Timestamp.now(),
    });
    //=> Record 1 transaction
    /*FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[0])
        .set({
      "A": [10, 0],
      "B": [0, 10],
      "C": [0, 10],
      "D": [0, 10],
    }); //A will get from B update
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[1])
        .set({
      "A": [10, 0],
      "B": [10, 0],
      //"C": [0, 0],
      //"D": [0, 0],
    }); //B will give to A update
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[2])
        .set({
      "A": [10, 0],
      "C": [0, 0],
      //"B": [0, 0],
      //"D": [0, 0],
    }); //C will give to A update
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[3])
        .set({
      "A": [10, 0],
      //"B": [0, 0],
      "D": [5, 0],
    }); //D will give to A update
    //** */
    // => Record 2
    */
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("records")
        .add({
      "paid_by": users[3],
      "paid_for": [users[2], users[3]],
      "amount": 10,
      "amount_due": 5,
      "category": "Travel",
      "description": "Test bullet train",
      "date_time": Timestamp.now(),
    });
    //=> Record 2 transaction
    /*
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[2])
        .set({
      "A": [10, 0],
      "B": [0, 0],
      "D": [5, 0],
      //==C will give D 5
    });
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[3])
        .set({
      "A": [10, 0],
      "B": [0, 0],
      "C": [0, 5],
    });*/
//** */
    // => Record 3
    /*FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("records")
        .add({
      "paid_by": users[1],
      "paid_for": [users[1], users[2], users[3]],
      "amount": 30,
      "amount_due": 10,
      "category": "Tea",
      "description": "Test Yellow tea",
      "date_time": Timestamp.now(),
    });*/
    //=> Record 3 transaction
    //Temp transaction
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[0])
        .set({
      "A": [10, 0],
      "B": [0, 10],
      "C": [0, 10],
      "D": [0, 10],
    });
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[1])
        .set({
      "A": [10, 0],
      //"B": [10, 0],
      //"C": [0, 10],
      //"D": [0, 10],
    });
    //B will get 10 from C
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[2])
        .set({
      "A": [10, 0],
      //"B": [10, 0],
      //"C": [0, 0],
      "D": [5, 0],
    });
    //C will give to B 10
    FirebaseFirestore.instance
        .collection("events")
        .doc(events[0])
        .collection("userData")
        .doc(users[3])
        .set({
      "A": [10, 0],
      //"B": [10, 0],
      "C": [0, 5],
      "D": [5, 0],
    });
    //D will give 10 to B
    //**3 records added ...... */
  }
}
