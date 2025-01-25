import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wander/data/model/dio_reponse.dart';
import 'package:wander/data/model/user.dart';
import '../core/connection.dart';
import '../core/endpoint.dart';
import '../core/shared_prefrence.dart';

class UsersController extends ChangeNotifier {
  final List<User> _users = [];

  UsersController() {
    _loadUsersFromSharedPreferences();
  }

  //load users from SharedPreferences
  Future<void> _loadUsersFromSharedPreferences() async {
    try {
      String? data = SharedPreference.getString(key: "users");
      if (data != null) {
        final List<dynamic> decodedData = jsonDecode(data);
        _users.clear();
        for (var e in decodedData) {
          _users.add(User.fromJson(e));
        }
        notifyListeners();
      }
    } catch (e) {
      throw Exception("Failed to load users from SharedPreferences: ${e.toString()}");
    }
  }

  //store users to SharedPreferences
  Future<void> _saveUsersToSharedPreferences() async {
    try {
      String encodedUsers = jsonEncode(_users.map((user) => user.toJson()).toList());
      await SharedPreference.setString(key: "users", value: encodedUsers);
    } catch (e) {
      throw Exception("Failed to save users to SharedPreferences: ${e.toString()}");
    }
  }

  //create a new user
  Future<int> addUser(User user) async {
    try {
      DioResponse res = await Connection.instance.post(
        url: Endpoint.users,
        data: user.toJson(),
      );

      if (res.isSuccess) {
        _users.add(user);
        await _saveUsersToSharedPreferences();
        notifyListeners();
        return 1; // Success
      } else {
        throw Exception("Failed to add user: ${res.message}");
      }
    } catch (e) {
      throw Exception("Failed to add user: ${e.toString()}");
    }
  }

  //remove a user
  Future<int> removeUser(User user) async {
    try {
      DioResponse res = await Connection.instance.delete(
        url: "${Endpoint.users}/${user.id}",
      );

      if (res.isSuccess) {
        _users.remove(user);
        await _saveUsersToSharedPreferences();
        notifyListeners();
        return 1; 
      } else {
        throw Exception("Failed to remove user: ${res.message}");
      }
    } catch (e) {
      throw Exception("Failed to remove user: ${e.toString()}");
    }
  }

  //update a user
  Future<int> updateUser(User oldUser, User newUser) async {
    try {
      final index = _users.indexWhere((user) => user.id == oldUser.id);
      if (index != -1) {
        DioResponse res = await Connection.instance.patch(
          url: "${Endpoint.users}/${oldUser.id}",
          data: newUser.toJson(),
        );

        if (res.isSuccess) {
          _users[index] = newUser;
          await _saveUsersToSharedPreferences();
          notifyListeners();
          return 1; 
        } else {
          throw Exception("Failed to update user: ${res.message}");
        }
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Failed to update user: ${e.toString()}");
    }
  }

  //fetch users from the API
//   Future<DioResponse> fetchUsers() async {
//     try {
//       DioResponse res = await Connection.instance.get(url: Endpoint.users);

//       if (res.isSuccess) {
//         _users.clear();
//         for (var e in res.data as List<dynamic>) {
//           _users.add(User.fromJson(e));
//         }
//         await _saveUsersToSharedPreferences();
//         notifyListeners();
//       }
//       return res;
//     } catch (e) {
//       throw Exception("Failed to fetch users: ${e.toString()}");
//     }
//   }

//   // Getter for users list
//   List<User> get users => _users;
}