import 'dart:async';
import 'package:eco_unity_flutter_app/screens/signupemail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int _currentImageIndex =
      0; // State variable to keep track of the current image index
  late Timer _timer; // Timer for automatic image change

  final List<String> _images = [
    'images/image.png',
    'images/image2.png',
    'images/image3.png',
    'images/image4.png',
  ];

  @override
  void initState() {
    super.initState();
    _startImageSlideshow();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startImageSlideshow() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _images.length;
      });
    });
  }

  void _changeImage(int index) {
    setState(() {
      _currentImageIndex = index;
    });
  }

  Future<void> _launchURL(String url) async {
    Uri _url = Uri.parse(url);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40), // Add space at the top
                Container(
                  width: 290,
                  height: 201,
                  child: Image.asset(
                    _images[_currentImageIndex], // Display the current image
                    key: ValueKey<int>(_currentImageIndex),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Sell Earn Reduce',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Make money while reducing waste',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_images.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.circle,
                          color: _currentImageIndex == index
                              ? Colors.green
                              : Colors.white,
                          size: 10,
                        ),
                        onPressed: () => _changeImage(index),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 30),
                SocialButton(
                  icon: FontAwesomeIcons.google,
                  text: 'Continue with Google',
                  color: Color.fromARGB(255, 250, 101, 14),
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () async {
                    try {
                      await signInWithGoogle();
                      // Navigate to the next screen if sign in is successful
                      Navigator.pushNamed(context, '/home');
                    } catch (e) {
                      // Handle errors
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Google Sign-In failed: $e'),
                        ),
                      );
                    }
                  },
                ),
                SocialButton(
                  icon: Icons.email,
                  text: 'Continue with Email',
                  color: Colors.blueGrey,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(context,
                        SignupemailScreen.routeName); // Navigate to SignupPage2
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'By signing up, you agree to our Terms of Service and Privacy Policy',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'version 2.321.32573.9',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 40), // Add space at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  SocialButton({
    required this.icon,
    required this.text,
    required this.color,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: color),
        label: Text(text, style: TextStyle(color: textColor)),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
