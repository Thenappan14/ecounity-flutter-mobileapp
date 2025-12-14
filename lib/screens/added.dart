import 'package:eco_unity_flutter_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddedScreen extends StatelessWidget {
  static String routeName = '/added';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 60,
            left: 30,
            child: Icon(
              FontAwesomeIcons.smile,
              color: Colors.white,
              size: 40,
            ),
          ),
          Positioned(
            top: 120,
            right: 70,
            child: Icon(
              FontAwesomeIcons.smile,
              color: Colors.yellow,
              size: 40,
            ),
          ),
          Positioned(
            bottom: 140,
            left: 50,
            child: Icon(
              FontAwesomeIcons.smile,
              color: Colors.yellow,
              size: 40,
            ),
          ),
          Positioned(
            bottom: 80,
            right: 90,
            child: Icon(
              FontAwesomeIcons.smile,
              color: Colors.white,
              size: 40,
            ),
          ),
          Positioned(
            top: 20,
            left: 100,
            child: Icon(
              FontAwesomeIcons.star,
              color: Colors.yellow,
              size: 30,
            ),
          ),
          Positioned(
            top: 70,
            right: 40,
            child: Icon(
              FontAwesomeIcons.star,
              color: Colors.white,
              size: 30,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            child: Icon(
              FontAwesomeIcons.star,
              color: Colors.white,
              size: 30,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 60,
            child: Icon(
              FontAwesomeIcons.star,
              color: Colors.yellow,
              size: 30,
            ),
          ),
          Positioned(
            top: 150,
            left: 150,
            child: Icon(
              FontAwesomeIcons.solidHeart,
              color: Colors.red,
              size: 30,
            ),
          ),
          Positioned(
            top: 90,
            right: 100,
            child: Icon(
              FontAwesomeIcons.solidHeart,
              color: Colors.pink,
              size: 30,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 120,
            child: Icon(
              FontAwesomeIcons.solidHeart,
              color: Colors.pink,
              size: 30,
            ),
          ),
          Positioned(
            bottom: 40,
            right: 30,
            child: Icon(
              FontAwesomeIcons.solidHeart,
              color: Colors.red,
              size: 30,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Product got added!!!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
