import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/user.dart';

class UsersController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<User> _users = [];

  UsersController() {
    _loadUsersFromFirestore();
  }

  //to load users from Firestore
  Future<void> _loadUsersFromFirestore() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('users').get();
      _users.clear();
      for (var doc in snapshot.docs) {
        _users.add(User.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
      }
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to load users from Firestore: ${e.toString()}");
    }
  }

  //to add a new user to Firestore
  Future<void> addUser(User user) async {
    try {
      final docRef = await _firestore.collection('users').add(user.toFirestore());
      user = user.copyWith(id: docRef.id); 
      _users.add(user);
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to add user: ${e.toString()}");
    }
  }

  Future<void> removeUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.id).delete();
      _users.remove(user);
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to remove user: ${e.toString()}");
    }
  }

  Future<void> updateUser(User oldUser, User newUser) async {
    try {
      await _firestore.collection('users').doc(oldUser.id).update(newUser.toFirestore());
      final index = _users.indexWhere((user) => user.id == oldUser.id);
      if (index != -1) {
        _users[index] = newUser;
        notifyListeners();
      }
    } catch (e) {
      throw Exception("Failed to update user: ${e.toString()}");
    }
  }

  Future<void> fetchUsers() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('users').get();
      _users.clear();
      for (var doc in snapshot.docs) {
        _users.add(User.fromFirestore(doc.data() as Map<String, dynamic>, doc.id));
      }
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to fetch users: ${e.toString()}");
    }
  }

  List<User> get users => _users;
}