//------------------------------------------------------version 2 with editable image-----------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------
// import 'dart:io';
// import 'package:eco_unity_flutter_app/firebase_service.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class EditProductScreen extends StatefulWidget {
//   final AddProduct product;

//   EditProductScreen({required this.product});

//   @override
//   _EditProductScreenState createState() => _EditProductScreenState();
// }

// class _EditProductScreenState extends State<EditProductScreen> {
//   final _productNameController = TextEditingController();
//   final _productDetailController = TextEditingController();
//   final _captionController = TextEditingController();
//   final _priceController = TextEditingController();
//   final FirebaseService _firebaseService = FirebaseService();
//   File? _imageFile;
//   String _selectedCategory = '';

//   @override
//   void initState() {
//     super.initState();
//     _productNameController.text = widget.product.name;
//     _productDetailController.text = widget.product.detail;
//     _captionController.text = widget.product.caption;
//     _priceController.text = widget.product.price;
//     _selectedCategory = widget.product.category;
//   }

//   @override
//   void dispose() {
//     _productNameController.dispose();
//     _productDetailController.dispose();
//     _captionController.dispose();
//     _priceController.dispose();
//     super.dispose();
//   }

//   Future<void> _saveChanges() async {
//     String imageUrl = widget.product.imageUrl;

//     if (_imageFile != null) {
//       imageUrl = await _firebaseService.uploadImage(_imageFile!);
//     }

//     final updatedProduct = AddProduct(
//       id: widget.product.id,
//       imageUrl: imageUrl,
//       name: _productNameController.text,
//       detail: _productDetailController.text,
//       caption: _captionController.text,
//       category: _selectedCategory,
//       price: _priceController.text,
//       timestamp: widget.product.timestamp,
//     );

//     await _firebaseService.updateProduct(
//       updatedProduct.id,
//       updatedProduct.imageUrl,
//       updatedProduct.name,
//       updatedProduct.detail,
//       updatedProduct.caption,
//       updatedProduct.category,
//       updatedProduct.price,
//     );

//     if (mounted) {
//       Navigator.pop(context, updatedProduct);
//     }
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('Edit Product', style: TextStyle(color: Colors.white)),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.save, color: Colors.white),
//             onPressed: _saveChanges,
//           ),
//         ],
//       ),
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Product Name',
//               style: TextStyle(color: Colors.white),
//             ),
//             TextField(
//               controller: _productNameController,
//               decoration: InputDecoration(
//                 hintText: 'Enter product name',
//                 hintStyle: TextStyle(color: Colors.grey),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//               ),
//               style: TextStyle(color: Colors.white),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Product Detail',
//               style: TextStyle(color: Colors.white),
//             ),
//             TextField(
//               controller: _productDetailController,
//               decoration: InputDecoration(
//                 hintText: 'Enter product detail',
//                 hintStyle: TextStyle(color: Colors.grey),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//               ),
//               style: TextStyle(color: Colors.white),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Caption',
//               style: TextStyle(color: Colors.white),
//             ),
//             TextField(
//               controller: _captionController,
//               decoration: InputDecoration(
//                 hintText: 'Enter product caption',
//                 hintStyle: TextStyle(color: Colors.grey),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//               ),
//               style: TextStyle(color: Colors.white),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Price',
//               style: TextStyle(color: Colors.white),
//             ),
//             TextField(
//               controller: _priceController,
//               decoration: InputDecoration(
//                 hintText: 'Enter product price',
//                 hintStyle: TextStyle(color: Colors.grey),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//               ),
//               style: TextStyle(color: Colors.white),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Category',
//               style: TextStyle(color: Colors.white),
//             ),
//             DropdownButton<String>(
//               value: _selectedCategory,
//               dropdownColor: Colors.black,
//               style: TextStyle(color: Colors.white),
//               items: <String>[
//                 'Likes',
//                 'Fruits',
//                 'Veges',
//                 'Drinks',
//                 'Seafood',
//                 'Deserts',
//                 'Carbo',
//                 'Medicine'
//               ].map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedCategory = newValue!;
//                 });
//               },
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Image',
//               style: TextStyle(color: Colors.white),
//             ),
//             GestureDetector(
//               onTap: _pickImage,
//               child: _imageFile != null
//                   ? Image.file(
//                       _imageFile!,
//                       height: 150,
//                     )
//                   : widget.product.imageUrl.isNotEmpty
//                       ? Image.network(
//                           widget.product.imageUrl,
//                           height: 150,
//                         )
//                       : Image.asset(
//                           'images/product1.png',
//                           height: 150,
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//------------------------------------------------version with input validation-------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------

import 'dart:io';
import 'package:eco_unity_flutter_app/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:eco_unity_flutter_app/screens/theme_notifier.dart'; // Import ThemeNotifier

class EditProductScreen extends StatefulWidget {
  final AddProduct product;

  EditProductScreen({required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _productNameController = TextEditingController();
  final _productDetailController = TextEditingController();
  final _captionController = TextEditingController();
  final _priceController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  File? _imageFile;
  String _selectedCategory = '';
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _productNameController.text = widget.product.name;
    _productDetailController.text = widget.product.detail;
    _captionController.text = widget.product.caption;
    _priceController.text = widget.product.price;
    _selectedCategory = widget.product.category;

    _productNameController.addListener(_validateForm);
    _productDetailController.addListener(_validateForm);
    _captionController.addListener(_validateForm);
    _priceController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productDetailController.dispose();
    _captionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _productNameController.text.isNotEmpty &&
          _productDetailController.text.isNotEmpty &&
          _captionController.text.isNotEmpty &&
          _priceController.text.isNotEmpty &&
          _selectedCategory.isNotEmpty;
    });
  }

  Future<void> _saveChanges() async {
    if (!_isFormValid) {
      _showAlertDialog();
      return;
    }

    String imageUrl = widget.product.imageUrl;

    if (_imageFile != null) {
      imageUrl = await _firebaseService.uploadImage(_imageFile!);
    }

    final updatedProduct = AddProduct(
      id: widget.product.id,
      imageUrl: imageUrl,
      name: _productNameController.text,
      detail: _productDetailController.text,
      caption: _captionController.text,
      category: _selectedCategory,
      price: _priceController.text,
      timestamp: widget.product.timestamp,
    );

    await _firebaseService.updateProduct(
      updatedProduct.id,
      updatedProduct.imageUrl,
      updatedProduct.name,
      updatedProduct.detail,
      updatedProduct.caption,
      updatedProduct.category,
      updatedProduct.price,
    );

    if (mounted) {
      Navigator.pop(context, updatedProduct);
    }
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Form Incomplete'),
          content: Text('Please fill in all fields before saving.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _validateForm();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeNotifier =
        Provider.of<ThemeNotifier>(context); // Get ThemeNotifier

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
        title: Text('Edit Product',
            style: TextStyle(
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.save,
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
            onPressed: _saveChanges,
          ),
        ],
      ),
      backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
      resizeToAvoidBottomInset:
          true, // This ensures that the UI resizes when the keyboard is shown
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Name',
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                hintText: 'Enter product name',
                hintStyle: TextStyle(
                    color: themeNotifier.isDarkMode
                        ? Colors.grey
                        : Colors.black54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: themeNotifier.isDarkMode
                          ? Colors.grey
                          : Colors.black54),
                ),
              ),
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Product Detail',
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            TextField(
              controller: _productDetailController,
              decoration: InputDecoration(
                hintText: 'Enter product detail',
                hintStyle: TextStyle(
                    color: themeNotifier.isDarkMode
                        ? Colors.grey
                        : Colors.black54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: themeNotifier.isDarkMode
                          ? Colors.grey
                          : Colors.black54),
                ),
              ),
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Caption',
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            TextField(
              controller: _captionController,
              decoration: InputDecoration(
                hintText: 'Enter product caption',
                hintStyle: TextStyle(
                    color: themeNotifier.isDarkMode
                        ? Colors.grey
                        : Colors.black54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: themeNotifier.isDarkMode
                          ? Colors.grey
                          : Colors.black54),
                ),
              ),
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              'Price',
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                hintText: 'Enter product price',
                hintStyle: TextStyle(
                    color: themeNotifier.isDarkMode
                        ? Colors.grey
                        : Colors.black54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: themeNotifier.isDarkMode
                          ? Colors.grey
                          : Colors.black54),
                ),
              ),
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Text(
              'Category',
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              dropdownColor:
                  themeNotifier.isDarkMode ? Colors.black : Colors.white,
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
              items: <String>[
                'Likes',
                'Fruits',
                'Veges',
                'Drinks',
                'Seafood',
                'Deserts',
                'Carbo',
                'Medicine'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                  _validateForm();
                });
              },
            ),
            SizedBox(height: 10),
            Text(
              'Image',
              style: TextStyle(
                  color:
                      themeNotifier.isDarkMode ? Colors.white : Colors.black),
            ),
            GestureDetector(
              onTap: _pickImage,
              child: _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      height: 150,
                    )
                  : widget.product.imageUrl.isNotEmpty
                      ? Image.network(
                          widget.product.imageUrl,
                          height: 150,
                        )
                      : Image.asset(
                          'images/product1.png',
                          height: 150,
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
