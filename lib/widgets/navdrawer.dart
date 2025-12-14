import 'package:eco_unity_flutter_app/screens/applelist.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool isFruitsExpanded =
      false; // Track whether the "Fruits" category is expanded

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Browse by categories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Close the drawer
                    },
                  ),
                ],
              ),
            ),
            _buildDrawerItemWithArrow(
                FontAwesomeIcons.carrot, 'Vegetables', context),
            ExpansionTile(
              leading: Icon(
                Icons.local_pizza,
                color: isFruitsExpanded
                    ? Colors.red
                    : Colors.white, // Change color based on expansion
              ),
              title: Text('Fruits', style: TextStyle(color: Colors.white)),
              trailing: Icon(
                isFruitsExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              children: <Widget>[
                _buildSubcategoryItem('All Fruits', context, () {}),
                _buildSubcategoryItem('Local Fruits', context, () {}),
                _buildSubcategoryItem('China', context, () {}),
                _buildSubcategoryItem('India', context, () {}),
                _buildSubcategoryItem('Malaysia', context, () {}),
                _buildSubcategoryItem('Apple', context, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppleListScreen(),
                    ),
                  );
                }),
                _buildSubcategoryItem('Mango', context, () {}),
                _buildSubcategoryItem('Grapes', context, () {}),
                _buildSubcategoryItem('Guava', context, () {}),
                _buildSubcategoryItem('Banana', context, () {}),
                _buildSubcategoryItem('Fruit Shakes', context, () {}),
                _buildSubcategoryItem('Fruit gummies', context, () {}),
              ],
              onExpansionChanged: (expanded) {
                setState(() {
                  isFruitsExpanded =
                      expanded; // Update the state based on expansion
                });
              },
            ),
            _buildDrawerItemWithArrow(Icons.fastfood, 'Fast Food', context),
            _buildDrawerItemWithArrow(
                FontAwesomeIcons.candyCane, 'Canned Food', context),
            _buildDrawerItemWithArrow(Icons.fastfood, 'Ready made', context),
            _buildDrawerItemWithArrow(Icons.soup_kitchen, 'Sauces', context),
            _buildDrawerItemWithArrow(Icons.local_drink, 'Drinks', context),
            _buildDrawerItemWithArrow(Icons.ramen_dining, 'Noodles', context),
            _buildDrawerItemWithArrow(
                FontAwesomeIcons.cookieBite, 'Chocolates', context),
            _buildDrawerItemWithArrow(
                FontAwesomeIcons.candyCane, 'Chips', context),
            _buildDrawerItemWithArrow(
                FontAwesomeIcons.candyCane, 'Candy', context),
            _buildDrawerItemWithArrow(Icons.lunch_dining, 'Meat', context),
            // Add more categories as needed
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItemWithArrow(
      IconData icon, String label, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white), // Set icon color to white
      title: Text(
        label,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
      trailing: Icon(Icons.keyboard_arrow_down, color: Colors.white),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildSubcategoryItem(
      String label, BuildContext context, Function onTap) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(color: Colors.white70),
      ),
      onTap: onTap as void Function()?,
    );
  }
}

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[800], // Grey background color for the TextField
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Apples',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search, color: Colors.white),
              filled: true,
              fillColor: Color.fromARGB(255, 55, 55, 55), // Fill color
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 55, 55, 55)), // Border color
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: Colors.white), // Border color when focused
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Colors.white,
            onPressed: () {
              // Handle cart action
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter and sort buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '50+ results in Singapore',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.white),
                  onPressed: () {
                    // Handle filter action
                  },
                ),
              ],
            ),
            // Product Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 6, // Number of products
                itemBuilder: (context, index) {
                  return _buildProductCard(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, int index) {
    return Card(
      color: Colors.white10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/product_$index.png', // Replace with your product image paths
                fit: BoxFit.cover,
                width: double.infinity,
                height: 100,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.favorite_border, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name $index',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  'Description for product $index',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 5),
                Text(
                  '\$$index.00',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NavDrawer(),
  ));
}
