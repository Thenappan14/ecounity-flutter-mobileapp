import 'package:eco_unity_flutter_app/screens/bought.dart';
import 'package:flutter/material.dart';

class Applespecification extends StatelessWidget {
  static String routeName = '/applespecification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Apple Fragrant Punnet',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding:
                EdgeInsets.only(bottom: 80), // Add padding to avoid overlap
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'images/apple1.png', // Make sure this image exists in your assets
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Fruits',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Fresh, aromatic apples from China in a delightful punnet, priced at \$5.30, offering a flavorful taste of international produce.',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      Divider(color: Colors.white),
                      ListTile(
                        leading: Icon(Icons.handshake, color: Colors.white),
                        title: Text(
                          'Deal Method',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Meet-up: Anywhere in Tampines',
                          style: TextStyle(color: Colors.white70),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ),
                      Divider(color: Colors.white),
                      ListTile(
                        leading: Icon(Icons.help, color: Colors.white),
                        title: Text(
                          'FAQ',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ),
                      Divider(color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        'Meet The Seller',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                        title: Text(
                          'Samuel',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Super responsive',
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              '1 year ago',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.verified,
                          color: Colors.blue,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.message, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.phone, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.email, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.facebook, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.message, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Add to Cart',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, BoughtScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Buy', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
