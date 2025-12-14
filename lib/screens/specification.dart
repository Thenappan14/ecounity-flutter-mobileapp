import 'package:flutter/material.dart';

class SpecificationScreen extends StatelessWidget {
  static String routeName = '/specification'; // Define route name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Specifications'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Specifications',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Name: Apple',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Description: This is a detailed description of the apple product.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'Price: \$1.00',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            // Add more specifications as needed
          ],
        ),
      ),
    );
  }
}
