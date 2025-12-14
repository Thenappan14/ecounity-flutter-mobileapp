import 'package:eco_unity_flutter_app/screens/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eco_unity_flutter_app/firebase_service.dart'; // Import FirebaseService
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import FirebaseFirestore

class UpdateUsernameScreen extends StatefulWidget {
  @override
  _UpdateUsernameScreenState createState() => _UpdateUsernameScreenState();
}

class _UpdateUsernameScreenState extends State<UpdateUsernameScreen> {
  final _newUsernameController = TextEditingController();
  final _confirmUsernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseService fbService =
      FirebaseService(); // Initialize FirebaseService
  bool _isProcessing = false;

  Future<void> _updateUsername() async {
    if (_passwordController.text.isEmpty ||
        _newUsernameController.text.isEmpty ||
        _confirmUsernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required.')),
      );
      return;
    }

    if (_newUsernameController.text != _confirmUsernameController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("The usernames do not match.")),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _passwordController.text,
        );

        await user.reauthenticateWithCredential(credential);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'username': _newUsernameController.text});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username updated successfully')),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'wrong-password':
          errorMessage = 'The password is incorrect.';
          break;
        default:
          errorMessage = 'An unknown error occurred. Code: ${e.code}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('An unexpected error occurred. Please try again.')),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeNotifier =
        Provider.of<ThemeNotifier>(context); // Get ThemeNotifier
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Username',
          style: TextStyle(
              color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                    color:
                        themeNotifier.isDarkMode ? Colors.white : Colors.black),
              ),
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _newUsernameController,
              decoration: InputDecoration(
                labelText: 'New Username',
                labelStyle: TextStyle(
                    color:
                        themeNotifier.isDarkMode ? Colors.white : Colors.black),
              ),
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _confirmUsernameController,
              decoration: InputDecoration(
                labelText: 'Confirm New Username',
                labelStyle: TextStyle(
                    color:
                        themeNotifier.isDarkMode ? Colors.white : Colors.black),
              ),
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 32.0),
            _isProcessing
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _updateUsername,
                    child: Text('Update Username'),
                  ),
          ],
        ),
      ),
    );
  }
}
