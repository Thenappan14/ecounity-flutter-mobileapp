import 'package:eco_unity_flutter_app/screens/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eco_unity_flutter_app/firebase_service.dart'; // Import FirebaseService
import 'package:eco_unity_flutter_app/main.dart'; // Import ThemeNotifier
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

class UpdatePasswordScreen extends StatefulWidget {
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final FirebaseService fbService =
      FirebaseService(); // Initialize FirebaseService
  bool _isProcessing = false;

  Future<void> _updatePassword() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      await fbService.updatePassword(
        _currentPasswordController.text,
        _newPasswordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password updated successfully')),
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
          errorMessage = 'Please log in again and try to update the password.';
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
          'Update Password',
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
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
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
                    onPressed: _updatePassword,
                    child: Text('Update Password'),
                  ),
          ],
        ),
      ),
    );
  }
}
