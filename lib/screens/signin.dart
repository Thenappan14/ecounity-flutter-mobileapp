// import 'package:eco_unity_flutter_app/firebase_service.dart';
// import 'package:eco_unity_flutter_app/screens/home.dart';
// import 'package:eco_unity_flutter_app/screens/signupemail.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get_it/get_it.dart';

// class SigninScreen extends StatefulWidget {
//   static String routeName = '/signin';

//   @override
//   _SigninScreenState createState() => _SigninScreenState();
// }

// class _SigninScreenState extends State<SigninScreen> {
//   final FirebaseService fbService = GetIt.instance<FirebaseService>();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;

//   String? email;
//   String? password;

//   Future<void> signIn(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       setState(() {
//         _isLoading = true;
//       });

//       print('Attempting to sign in with email: $email and password: $password');

//       try {
//         final userCredential = await fbService.login(email!, password!);
//         final user = userCredential.user;
//         if (user != null) {
//           print('Sign in successful, user: $user');
//           Navigator.pushNamed(context, HomeScreen.routeName);
//         } else {
//           print('Sign in failed, user returned null');
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//                 content: Text('Login failed. Please check your credentials.')),
//           );
//         }
//       } catch (error) {
//         print('Error during sign in: $error');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${error.toString()}')),
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 10),
//                   Image.asset(
//                     'images/logo.png',
//                     height: 180,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'EcoUnity',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Welcome Back',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Log into your account',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   _buildTextField(
//                     context,
//                     icon: Icons.person,
//                     hintText: 'Email Address',
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please provide an email address.';
//                       }
//                       if (!value.contains('@')) {
//                         return 'Please provide a valid email address.';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) => email = value,
//                   ),
//                   SizedBox(height: 10),
//                   _buildTextField(
//                     context,
//                     icon: Icons.lock,
//                     hintText: 'Password',
//                     obscureText: true,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please provide a password.';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be at least 6 characters.';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) => password = value,
//                   ),
//                   SizedBox(height: 20),
//                   if (_isLoading)
//                     CircularProgressIndicator()
//                   else
//                     ElevatedButton(
//                       onPressed: () => signIn(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                         textStyle: TextStyle(fontSize: 18),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Text(
//                         'Sign In',
//                         style: TextStyle(
//                             color: Colors.white), // Set text color to white
//                       ),
//                     ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Or sign in with',
//                     style: TextStyle(color: Colors.white70, fontSize: 14),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: FaIcon(FontAwesomeIcons.google,
//                             color: Colors.white),
//                         onPressed: () {
//                           // Handle Google sign in
//                         },
//                       ),
//                       SizedBox(width: 20),
//                       IconButton(
//                         icon: FaIcon(FontAwesomeIcons.facebook,
//                             color: Colors.white),
//                         onPressed: () {
//                           // Handle Facebook sign in
//                         },
//                       ),
//                       SizedBox(width: 20),
//                       IconButton(
//                         icon:
//                             FaIcon(FontAwesomeIcons.apple, color: Colors.white),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   RichText(
//                     text: TextSpan(
//                       text: "Don't have an account? ",
//                       style: TextStyle(color: Colors.white70),
//                       children: [
//                         TextSpan(
//                           text: 'Sign up here',
//                           style: TextStyle(color: Colors.green),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () {
//                               Navigator.pushNamed(
//                                   context, SignupemailScreen.routeName);
//                             },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     BuildContext context, {
//     required IconData icon,
//     required String hintText,
//     bool obscureText = false,
//     required String? Function(String?)? validator,
//     required void Function(String?)? onSaved,
//   }) {
//     return TextFormField(
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.white),
//         hintText: hintText,
//         hintStyle: TextStyle(color: Colors.white),
//         filled: true,
//         fillColor: Colors.white24,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       style: TextStyle(color: Colors.white),
//       validator: validator,
//       onSaved: onSaved,
//     );
//   }
// }

//------------------------------------------------------version with forgot password----------------------------------------------------

// import 'package:eco_unity_flutter_app/firebase_service.dart';
// import 'package:eco_unity_flutter_app/screens/home.dart';
// import 'package:eco_unity_flutter_app/screens/signup.dart';
// import 'package:eco_unity_flutter_app/screens/signupemail.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get_it/get_it.dart';

// class SigninScreen extends StatefulWidget {
//   static String routeName = '/signin';

//   @override
//   _SigninScreenState createState() => _SigninScreenState();
// }

// class _SigninScreenState extends State<SigninScreen> {
//   final FirebaseService fbService = GetIt.instance<FirebaseService>();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;

//   String? email;
//   String? password;
//   String? errorMessage;

//   Future<void> signIn(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       setState(() {
//         _isLoading = true;
//         errorMessage = null; // Reset error message
//       });

//       print('Attempting to sign in with email: $email and password: $password');

//       try {
//         final userCredential = await fbService.login(email!, password!);
//         final user = userCredential.user;
//         if (user != null) {
//           print('Sign in successful, user: $user');
//           Navigator.pushNamed(context, HomeScreen.routeName);
//         } else {
//           print('Sign in failed, user returned null');
//           setState(() {
//             errorMessage = 'Login failed. Please check your credentials.';
//           });
//         }
//       } catch (error) {
//         print('Error during sign in: $error');
//         setState(() {
//           errorMessage = 'Password is wrong. ';
//         });
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 10),
//                   Image.asset(
//                     'images/logo.png',
//                     height: 180,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'EcoUnity',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Welcome Back',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Log into your account',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   _buildTextField(
//                     context,
//                     icon: Icons.person,
//                     hintText: 'Email Address',
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please provide an email address.';
//                       }
//                       if (!value.contains('@')) {
//                         return 'Please provide a valid email address.';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) => email = value,
//                   ),
//                   SizedBox(height: 10),
//                   _buildTextField(
//                     context,
//                     icon: Icons.lock,
//                     hintText: 'Password',
//                     obscureText: true,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please provide a password.';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be at least 6 characters.';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) => password = value,
//                   ),
//                   SizedBox(height: 20),
//                   if (_isLoading)
//                     CircularProgressIndicator()
//                   else
//                     ElevatedButton(
//                       onPressed: () => signIn(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                         textStyle: TextStyle(fontSize: 18),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Text(
//                         'Sign In',
//                         style: TextStyle(
//                             color: Colors.white), // Set text color to white
//                       ),
//                     ),
//                   SizedBox(height: 20),
//                   if (errorMessage != null)
//                     Column(
//                       children: [
//                         Text(
//                           errorMessage!,
//                           style: TextStyle(color: Colors.red, fontSize: 14),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             fbService.forgotPassword(email!);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                   content: Text('Password reset email sent.')),
//                             );
//                           },
//                           child: Text(
//                             'Forgot Password?',
//                             style: TextStyle(color: Colors.green),
//                           ),
//                         ),
//                       ],
//                     ),
//                   Text(
//                     'Or sign in with',
//                     style: TextStyle(color: Colors.white70, fontSize: 14),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: FaIcon(FontAwesomeIcons.google,
//                             color: Colors.white),
//                         onPressed: () {
//                           // Handle Google sign in
//                         },
//                       ),
//                       SizedBox(width: 20),
//                       IconButton(
//                         icon: FaIcon(FontAwesomeIcons.facebook,
//                             color: Colors.white),
//                         onPressed: () {
//                           // Handle Facebook sign in
//                         },
//                       ),
//                       SizedBox(width: 20),
//                       IconButton(
//                         icon:
//                             FaIcon(FontAwesomeIcons.apple, color: Colors.white),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   RichText(
//                     text: TextSpan(
//                       text: "Don't have an account? ",
//                       style: TextStyle(color: Colors.white70),
//                       children: [
//                         TextSpan(
//                           text: 'Sign up here',
//                           style: TextStyle(color: Colors.green),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () {
//                               Navigator.pushNamed(
//                                   context, SignupScreen.routeName);
//                             },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     BuildContext context, {
//     required IconData icon,
//     required String hintText,
//     bool obscureText = false,
//     required String? Function(String?)? validator,
//     required void Function(String?)? onSaved,
//   }) {
//     return TextFormField(
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.white),
//         hintText: hintText,
//         hintStyle: TextStyle(color: Colors.white),
//         filled: true,
//         fillColor: Colors.white24,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       style: TextStyle(color: Colors.white),
//       validator: validator,
//       onSaved: onSaved,
//     );
//   }
// }

//-------------------------------------------------version with username signin--------------------------------------------------------

import 'package:eco_unity_flutter_app/firebase_service.dart';
import 'package:eco_unity_flutter_app/screens/home.dart';
import 'package:eco_unity_flutter_app/screens/signup.dart';
import 'package:eco_unity_flutter_app/screens/signupemail.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

class SigninScreen extends StatefulWidget {
  static String routeName = '/signin';

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final FirebaseService fbService = GetIt.instance<FirebaseService>();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String? username;
  String? password;
  String? errorMessage;

  Future<void> signIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
        errorMessage = null; // Reset error message
      });

      print(
          'Attempting to sign in with username: $username and password: $password');

      try {
        String? email = await fbService.getEmailFromUsername(username!);
        if (email == null) {
          setState(() {
            errorMessage = 'No user found with this username.';
            _isLoading = false;
          });
          return;
        }

        final userCredential = await fbService.login(email, password!);
        final user = userCredential.user;
        if (user != null) {
          print('Sign in successful, user: $user');
          Navigator.pushNamed(context, HomeScreen.routeName);
        } else {
          print('Sign in failed, user returned null');
          setState(() {
            errorMessage = 'Login failed. Please check your credentials.';
          });
        }
      } catch (error) {
        print('Error during sign in: $error');
        setState(() {
          errorMessage = 'Password is wrong. ';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Image.asset(
                    'images/logo.png',
                    height: 180,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'EcoUnity',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Log into your account',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildTextField(
                    context,
                    icon: Icons.person,
                    hintText: 'Username',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a username.';
                      }
                      return null;
                    },
                    onSaved: (value) => username = value,
                  ),
                  SizedBox(height: 10),
                  _buildTextField(
                    context,
                    icon: Icons.lock,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a password.';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) => password = value,
                  ),
                  SizedBox(height: 20),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: () => signIn(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white), // Set text color to white
                      ),
                    ),
                  SizedBox(height: 20),
                  if (errorMessage != null)
                    Column(
                      children: [
                        Text(
                          errorMessage!,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            fbService.forgotPassword(
                                username!); // Note: this should be the email
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Password reset email sent.')),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  Text(
                    'Or sign in with',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.google,
                            color: Colors.white),
                        onPressed: () {
                          // Handle Google sign in
                        },
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.facebook,
                            color: Colors.white),
                        onPressed: () {
                          // Handle Facebook sign in
                        },
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon:
                            FaIcon(FontAwesomeIcons.apple, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.white70),
                      children: [
                        TextSpan(
                          text: 'Sign up here',
                          style: TextStyle(color: Colors.green),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, SignupScreen.routeName);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required IconData icon,
    required String hintText,
    bool obscureText = false,
    required String? Function(String?)? validator,
    required void Function(String?)? onSaved,
  }) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
