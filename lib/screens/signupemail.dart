//--------------------------------------------------version with new fields-----------------------------------------------------------

import 'package:eco_unity_flutter_app/firebase_service.dart';
import 'package:eco_unity_flutter_app/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SignupemailScreen extends StatelessWidget {
  static String routeName = '/signupemail'; // Define the route name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/logo.png', height: 200, width: 200),
                SizedBox(height: 10),
                Text(
                  'Sign Up with Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                RegisterForm(),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SigninScreen.routeName);
                  },
                  child: Text(
                    'Already have an account? Log in',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final FirebaseService fbService = GetIt.instance<FirebaseService>();
  final form = GlobalKey<FormState>();

  String? email;
  String? password;
  String? confirmPassword;
  String? username;
  String? phoneNumber;
  String? address;

  void register(BuildContext context) {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      if (password != confirmPassword) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Password and Confirm Password do not match!')),
        );
        return;
      }

      fbService
          .register(email!, password!, username!, phoneNumber!, address!)
          .then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Registered successfully!')),
        );
        Navigator.pushNamed(context, SigninScreen.routeName);
      }).catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            icon: Icons.phone,
            hintText: 'Phone Number',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please provide a phone number.';
              }
              return null;
            },
            onSaved: (value) => phoneNumber = value,
          ),
          SizedBox(height: 10),
          _buildTextField(
            context,
            icon: Icons.location_on,
            hintText: 'Address',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please provide an address.';
              }
              return null;
            },
            onSaved: (value) => address = value,
          ),
          SizedBox(height: 10),
          _buildTextField(
            context,
            icon: Icons.email,
            hintText: 'Email Address',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please provide an email address.';
              }
              if (!value.contains('@')) {
                return 'Please provide a valid email address.';
              }
              return null;
            },
            onSaved: (value) => email = value,
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
          SizedBox(height: 10),
          _buildTextField(
            context,
            icon: Icons.lock,
            hintText: 'Confirm Password',
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
            onSaved: (value) => confirmPassword = value,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => register(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Register'),
          ),
        ],
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
