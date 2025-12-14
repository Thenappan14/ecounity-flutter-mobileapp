import 'package:eco_unity_flutter_app/screens/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eco_unity_flutter_app/firebase_service.dart'; // Import FirebaseService
import 'package:eco_unity_flutter_app/main.dart'; // Import ThemeNotifier
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

class UpdatePhoneNumberScreen extends StatefulWidget {
  @override
  _UpdatePhoneNumberScreenState createState() =>
      _UpdatePhoneNumberScreenState();
}

class _UpdatePhoneNumberScreenState extends State<UpdatePhoneNumberScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPhoneNumberController = TextEditingController();
  final _confirmPhoneNumberController = TextEditingController();
  final FirebaseService fbService =
      FirebaseService(); // Initialize FirebaseService
  bool _isProcessing = false;

  Future<void> _updatePhoneNumber() async {
    if (_newPhoneNumberController.text != _confirmPhoneNumberController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("The phone numbers do not match.")),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      await fbService.updatePhoneNumber(
        _currentPasswordController.text,
        _newPhoneNumberController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number updated successfully')),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      print("Error code: ${e.code}");
      print("Error message: ${e.message}");
      switch (e.code) {
        case 'wrong-password':
          errorMessage = 'The current password is incorrect.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for the given credentials.';
          break;
        case 'user-mismatch':
          errorMessage = 'The credential does not correspond to the user.';
          break;
        case 'invalid-credential':
          errorMessage = 'The credential is invalid.';
          break;
        case 'requires-recent-login':
          errorMessage =
              'Please log in again and try to update the phone number.';
          break;
        default:
          errorMessage = 'An unknown error occurred. Code: ${e.code}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      print("Non-FirebaseAuthException error: $e");
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
          'Update Phone Number',
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
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
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
              controller: _newPhoneNumberController,
              decoration: InputDecoration(
                labelText: 'New Phone Number',
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
              controller: _confirmPhoneNumberController,
              decoration: InputDecoration(
                labelText: 'Confirm New Phone Number',
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
                    onPressed: _updatePhoneNumber,
                    child: Text('Update Phone Number'),
                  ),
          ],
        ),
      ),
    );
  }
}
