import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../screens/drawer_screen.dart';

import '../screens/signup_screen.dart';
import '../utils/constants.dart';


class AuthService {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required bool isAdmin,
    required String serial,
  }) async {
    try {
      Map<String, dynamic> userData = {
        'mail': email,
        'password': password,
        'username': name,
        'isAdmin': isAdmin,
        'serial': serial,
      };

      String jsonData = jsonEncode(userData);

      http.Response res = await http.post(
        Uri.parse('http://${Constants.serverIP}:/api/auth/register'),//${Constants.serverPort}
        body: jsonData,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created! Login with the same credentials!'),
          ),
        );
      } else if (res.statusCode == 409) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email already in use'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error occurred. Please try again'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<bool> signInUser({
    required BuildContext context,
    required String email,
    required String password,
    required bool isAdmin,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('http://${Constants.serverIP}:/api/auth/login'),//${Constants.serverPort}
        body: jsonEncode({
          'mail': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        String token = data['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('x-auth-token', token);
        prefs.setString('email', email);
        prefs.setBool('isAdmin', isAdmin);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainDrawer(title: 'drawer'),
          ),
        );

        return true;
      } else if (res.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
          ),
        );
        return false;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error occurred. Please try again'),
          ),
        );
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      return false;
    }
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('x-auth-token');
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<bool?> isAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAdmin');
  }



  Future<void> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('http://${Constants.serverIP}:/api/auth/'),//${Constants.serverPort}

        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        print('Message sent successfully');
      } else {
        print('Failed to send message');
      }
    } catch (error) {
      print('Error sending message: $error');
    }
  }


  // Function to save chat message to server
  Future<void> saveChatMessage(String username, String receiver, String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    final url = Uri.parse('http://${Constants.serverIP}:/api/chat/save');//${Constants.serverPort}
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(
        {' username': username, 'receiver': receiver, 'message': message});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Chat message saved successfully');
      } else {
        print('Failed to save chat message');
      }
    } catch (error) {
      print('Error saving chat message: $error');
    }
  }

  Future<bool> setUserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("username",value);
  }






  Future<void> fetchUserDetails(String serial, String authToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    String? email = prefs.getString('email');
    bool? isAdmin = prefs.getBool('isAdmin');
    final url = Uri.parse('http://${Constants.serverIP}:/api/user/$serial');//${Constants.serverPort}

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken', // Pass the auth token in the request headers
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> responseData = json.decode(response.body);
        final user = responseData['user'];
        print('User details: $user');
      } else if (response.statusCode == 404) {
        print('User not found');
      } else {
        // If the server returns an error response, throw an exception.
        throw Exception('Failed to load user details');
      }
    } catch (error) {
      print('Error fetching user details: $error');
      // Handle error gracefully
    }
  }





  void signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('x-auth-token');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
          (route) => false,
    );
  }
}
