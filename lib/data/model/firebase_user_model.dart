

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserModel {

  final String name;
  final String email;
  final String phone;


  FirebaseUserModel({

    required this.email,
    required this.name,
    required this.phone,

  });
  factory FirebaseUserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FirebaseUserModel(
      name: data?['name'],
      email: data?['email'],
      phone: data?['phone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
    };
  }
}
