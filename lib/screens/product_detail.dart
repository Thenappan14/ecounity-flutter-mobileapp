import 'package:eco_unity_flutter_app/firebase_service.dart';
import 'package:eco_unity_flutter_app/screens/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'edit_product.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final AddProduct product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    var themeNotifier =
        Provider.of<ThemeNotifier>(context); // Get ThemeNotifier
    final FirebaseService _firebaseService = FirebaseService();

    void _deleteProduct() async {
      bool confirmDelete = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        ),
      );
      if (confirmDelete) {
        await _firebaseService.deleteProduct(product.id);
        Navigator.pop(context); // Go back to the previous screen
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(product.name, style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.edit,
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProductScreen(product: product),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete,
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
            onPressed: _deleteProduct,
          ),
        ],
      ),
      backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              product.imageUrl.isNotEmpty
                  ? Image.network(
                      product.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'images/product1.png',
                      height: 200,
                      width: double.infinity,
                    ),
              SizedBox(height: 16),
              Text(
                product.name,
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '\$${product.price}',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Details',
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.detail,
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Caption',
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.caption,
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Category',
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.category,
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
