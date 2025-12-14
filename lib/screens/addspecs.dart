import 'package:eco_unity_flutter_app/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'added.dart';
import 'package:provider/provider.dart';
import 'package:eco_unity_flutter_app/screens/theme_notifier.dart'; // Import ThemeNotifier

class AddspecsScreen extends StatefulWidget {
  static String routeName = '/addspecs';

  @override
  _AddspecsScreenState createState() => _AddspecsScreenState();
}

class _AddspecsScreenState extends State<AddspecsScreen> {
  final _productNameController = TextEditingController();
  final _productDetailController = TextEditingController();
  final _captionController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedCategory = '';
  File? _imageFile;
  final FirebaseService _firebaseService = FirebaseService();

  bool get _isStepOneCompleted {
    return _productNameController.text.isNotEmpty &&
        _productDetailController.text.isNotEmpty &&
        _captionController.text.isNotEmpty;
  }

  bool get _isStepTwoCompleted {
    return _isStepOneCompleted && _selectedCategory.isNotEmpty;
  }

  bool get _isStepThreeCompleted {
    return _isStepTwoCompleted && _priceController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productDetailController.dispose();
    _captionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _addProduct() async {
    String imageUrl = '';
    if (_imageFile != null) {
      imageUrl = await _firebaseService.uploadImage(_imageFile!);
    }

    await _firebaseService.addProduct(
      imageUrl,
      _productNameController.text,
      _productDetailController.text,
      _captionController.text,
      _selectedCategory,
      _priceController.text,
    );

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeNotifier =
        Provider.of<ThemeNotifier>(context); // Get ThemeNotifier

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Product Details',
          style: TextStyle(
            color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _imageFile != null
                    ? Image.file(_imageFile!, height: 150)
                    : Container(
                        height: 150,
                        color: themeNotifier.isDarkMode
                            ? Colors.grey[800]
                            : Colors.grey[300],
                        child: Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: themeNotifier.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 10),
              StepperWidget(
                isStepOneCompleted: _isStepOneCompleted,
                isStepTwoCompleted: _isStepTwoCompleted,
                isStepThreeCompleted: _isStepThreeCompleted,
              ),
              SizedBox(height: 10),
              Text(
                'Product Name',
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              TextField(
                controller: _productNameController,
                decoration: InputDecoration(
                  hintText: 'Give product name',
                  hintStyle: TextStyle(
                    color:
                        themeNotifier.isDarkMode ? Colors.grey : Colors.black54,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: themeNotifier.isDarkMode
                          ? Colors.grey
                          : Colors.black54,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                ),
                onChanged: (value) => setState(() {}),
              ),
              SizedBox(height: 10),
              Text(
                'Product Detail',
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              TextField(
                controller: _productDetailController,
                decoration: InputDecoration(
                  hintText: 'Describe product (50 words)',
                  hintStyle: TextStyle(
                    color:
                        themeNotifier.isDarkMode ? Colors.grey : Colors.black54,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: themeNotifier.isDarkMode
                          ? Colors.grey
                          : Colors.black54,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                ),
                onChanged: (value) => setState(() {}),
              ),
              SizedBox(height: 10),
              Text(
                'Caption',
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              TextField(
                controller: _captionController,
                decoration: InputDecoration(
                  hintText: 'Write catchy caption',
                  hintStyle: TextStyle(
                    color:
                        themeNotifier.isDarkMode ? Colors.grey : Colors.black54,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: themeNotifier.isDarkMode
                          ? Colors.grey
                          : Colors.black54,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                ),
                onChanged: (value) => setState(() {}),
              ),
              SizedBox(height: 10),
              Text(
                'Category',
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Wrap(
                spacing: 50.0,
                runSpacing: 30.0,
                children: [
                  CategoryIcon(
                    icon: Icons.favorite,
                    label: 'Likes',
                    isSelected: _selectedCategory == 'Likes',
                    onTap: () => _onCategorySelected('Likes'),
                  ),
                  CategoryIcon(
                    icon: Icons.apple,
                    label: 'Fruits',
                    isSelected: _selectedCategory == 'Fruits',
                    onTap: () => _onCategorySelected('Fruits'),
                  ),
                  CategoryIcon(
                    icon: Icons.local_dining,
                    label: 'Veges',
                    isSelected: _selectedCategory == 'Veges',
                    onTap: () => _onCategorySelected('Veges'),
                  ),
                  CategoryIcon(
                    icon: Icons.local_drink,
                    label: 'Drinks',
                    isSelected: _selectedCategory == 'Drinks',
                    onTap: () => _onCategorySelected('Drinks'),
                  ),
                  CategoryIcon(
                    icon: Icons.cake,
                    label: 'Deserts',
                    isSelected: _selectedCategory == 'Deserts',
                    onTap: () => _onCategorySelected('Deserts'),
                  ),
                  CategoryIcon(
                    icon: Icons.rice_bowl,
                    label: 'Carbo',
                    isSelected: _selectedCategory == 'Carbo',
                    onTap: () => _onCategorySelected('Carbo'),
                  ),
                  CategoryIcon(
                    icon: Icons.medical_services,
                    label: 'Medicine',
                    isSelected: _selectedCategory == 'Medicine',
                    onTap: () => _onCategorySelected('Medicine'),
                  ),
                  CategoryIcon(
                    icon: FontAwesomeIcons.fish,
                    label: 'Seafood',
                    isSelected: _selectedCategory == 'Seafood',
                    onTap: () => _onCategorySelected('Seafood'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Price',
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Give a suitable price',
                  hintStyle: TextStyle(
                    color:
                        themeNotifier.isDarkMode ? Colors.grey : Colors.black54,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: themeNotifier.isDarkMode
                          ? Colors.grey
                          : Colors.black54,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                ),
                onChanged: (value) => setState(() {}),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                color: Colors.green,
                child: TextButton(
                  onPressed: _isStepThreeCompleted
                      ? _addProduct
                      : null, // Disable if step not completed
                  child: Text(
                    'Add product',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StepperWidget extends StatelessWidget {
  final bool isStepOneCompleted;
  final bool isStepTwoCompleted;
  final bool isStepThreeCompleted;

  StepperWidget({
    required this.isStepOneCompleted,
    required this.isStepTwoCompleted,
    required this.isStepThreeCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StepCircle(isActive: true, label: '1'),
        StepLine(isActive: true),
        StepCircle(isActive: isStepOneCompleted, label: '2'),
        StepLine(isActive: isStepTwoCompleted),
        StepCircle(isActive: isStepTwoCompleted, label: '3'),
        StepLine(isActive: isStepThreeCompleted),
        StepCircle(isActive: isStepThreeCompleted, label: '4'),
      ],
    );
  }
}

class StepCircle extends StatelessWidget {
  final bool isActive;
  final String label;

  StepCircle({required this.isActive, required this.label});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: isActive ? Colors.green : Colors.grey,
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class StepLine extends StatelessWidget {
  final bool isActive;

  StepLine({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? Colors.green : Colors.grey,
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  CategoryIcon({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: isSelected ? Colors.green : Colors.grey,
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: Provider.of<ThemeNotifier>(context).isDarkMode
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
