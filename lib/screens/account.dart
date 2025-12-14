import 'package:eco_unity_flutter_app/screens/theme_notifier.dart';
import 'package:eco_unity_flutter_app/screens/updateAddress.dart';
import 'package:eco_unity_flutter_app/screens/updatePhoneNumber.dart';
import 'package:eco_unity_flutter_app/screens/updatepassword.dart';
import 'package:eco_unity_flutter_app/screens/updateusername.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:eco_unity_flutter_app/firebase_service.dart';
import 'package:eco_unity_flutter_app/screens/signin.dart';
import 'package:eco_unity_flutter_app/main.dart';

class AccountScreen extends StatefulWidget {
  static String routeName = '/account';

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseService fbService = GetIt.instance<FirebaseService>();
  User? _user;
  String? _username;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Map<String, dynamic>? userDetails =
          await fbService.getUserDetails(user.uid);
      setState(() {
        _user = user;
        _username = userDetails?['username'] ?? 'Loading...';
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
          'Account',
          style: TextStyle(
              color: themeNotifier.isDarkMode
                  ? Colors.white
                  : Colors.black), // Set the text color based on the theme
        ),
        backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeNotifier.isDarkMode
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
              color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              themeNotifier.toggleTheme(); // Toggle the theme
            },
          ),
        ],
      ),
      backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color:
                        themeNotifier.isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _username ?? 'Loading...',
                      style: TextStyle(
                        color: themeNotifier.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    GestureDetector(
                      child: Text(
                        'Edit profile',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Divider(
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ListTile(
              leading: Icon(Icons.email,
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
              title: Text('Email',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white
                          : Colors.black)),
              subtitle: Text(_user?.email ?? 'Loading...',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white70
                          : Colors.black87)),
              onTap: () {
                // Handle email action
              },
            ),
            Divider(
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ListTile(
              leading: Icon(Icons.phone,
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
              title: Text('Phone',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white
                          : Colors.black)),
              subtitle: Text('Change or edit phone number',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white70
                          : Colors.black87)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdatePhoneNumberScreen()),
                );
                // Handle phone action
              },
            ),
            Divider(
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ListTile(
              leading: Icon(Icons.person,
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
              title: Text('Username',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white
                          : Colors.black)),
              subtitle: Text('Able to change username 2 times',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white70
                          : Colors.black87)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateUsernameScreen()),
                );
                // Handle username action
              },
            ),
            Divider(
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ListTile(
              leading: Icon(Icons.location_on,
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
              title: Text('Address',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white
                          : Colors.black)),
              subtitle: Text('Click to update your location',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white70
                          : Colors.black87)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateAddressScreen()),
                );
                // Handle address action
              },
            ),
            Divider(
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ListTile(
              leading: Icon(Icons.person,
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
              title: Text('Password',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white
                          : Colors.black)),
              subtitle: Text('Click to change password',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white70
                          : Colors.black87)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdatePasswordScreen(),
                  ),
                );
                // Handle username action
              },
            ),
            Divider(
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ListTile(
              leading: Icon(Icons.notifications,
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
              title: Text('Notifications',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white
                          : Colors.black)),
              onTap: () {
                // Handle notifications action
              },
            ),
            Divider(
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ListTile(
              leading: Icon(Icons.power_settings_new,
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
              title: Text('Log out',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white
                          : Colors.black)),
              onTap: () {
                fbService.logOut().then((value) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    SigninScreen.routeName,
                    (Route<dynamic> route) => false,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
