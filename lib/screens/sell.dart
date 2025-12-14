import 'package:flutter/material.dart';
import 'home.dart'; // Make sure this is the correct import for your HomeScreen
import 'addproduct.dart'; // Import the Add Product screen

class SellScreen extends StatelessWidget {
  static String routeName = '/sell';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'List anything yourself',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AddproductScreen.routeName);
              },
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: Colors.grey, size: 50),
                      SizedBox(height: 10),
                      Text(
                        'Add a photo to start a listing',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Beta',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Or Sell to EcoUnity',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              'No Listing needed, sell directly to us',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildSellOption(
              context,
              'Rice & Flours',
              'Doorstep pickup, instant cash out',
              'images/rice.png', // Replace with your image asset
            ),
            _buildSellOption(
              context,
              'Bottles',
              'Get rid of the heavy weight',
              'images/drink.png', // Replace with your image asset
            ),
            _buildSellOption(
              context,
              'Fruits & Vegetables',
              'Do not waste them if unused!!',
              'images/fruit.png', // Replace with your image asset
            ),
            _buildSellOption(
              context,
              'Canned Food',
              'It might help someone out there',
              'images/can.png', // Replace with your image asset
            ),
            _buildSellOption(
              context,
              'Ready-made',
              'Instant food for the needy',
              'images/readymade.png', // Replace with your image asset
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSellOption(
      BuildContext context, String title, String subtitle, String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Image.asset(imagePath,
              height: 50, width: 50), // Image aligned to the right
        ],
      ),
    );
  }
}
