import 'package:eco_unity_flutter_app/firebase_service.dart';
import 'package:eco_unity_flutter_app/screens/account.dart';
import 'package:eco_unity_flutter_app/screens/addspecs.dart';
import 'package:eco_unity_flutter_app/screens/learn.dart';
import 'package:eco_unity_flutter_app/screens/map.dart';
import 'package:eco_unity_flutter_app/screens/product_detail.dart';
import 'package:eco_unity_flutter_app/widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:eco_unity_flutter_app/screens/theme_notifier.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 2; // Set the default selected index to 2
  final FirebaseService _firebaseService = FirebaseService();
  String _selectedCategory = 'Categories Available - All';
  String _selectedPriceRange = 'Price Ranges - All';
  TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild to show/hide category dropdown
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 3) {
      // Navigate to SustainabilityScreen when "Learn" is tapped
      Navigator.pushNamed(context, LearnScreen.routeName);
    } else if (index == 4) {
      // Navigate to AccountScreen when "Me" is tapped
      Navigator.pushNamed(context, AccountScreen.routeName);
    } else if (index == 1) {
      // Navigate to SellScreen when "Sell" is tapped
      Navigator.pushNamed(context, AddspecsScreen.routeName);
    } else if (index == 0) {
      Navigator.pushNamed(context, MapScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeNotifier =
        Provider.of<ThemeNotifier>(context); // Get ThemeNotifier

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: themeNotifier.isDarkMode
                ? Colors.grey[800]
                : Colors.grey[300], // Grey background color for the TextField
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search with EcoUnity',
              hintStyle: TextStyle(
                color: themeNotifier.isDarkMode
                    ? Colors.white
                    : Colors.black, // Text color based on theme
              ),
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.search,
                color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
              ),
              filled: true,
              fillColor: themeNotifier.isDarkMode
                  ? const Color.fromARGB(255, 55, 55, 55)
                  : const Color.fromARGB(255, 200, 200, 200), // Fill color
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: themeNotifier.isDarkMode
                      ? const Color.fromARGB(255, 55, 55, 55)
                      : const Color.fromARGB(
                          255, 200, 200, 200), // Border color
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: themeNotifier.isDarkMode
                      ? Colors.white
                      : Colors.black, // Border color when focused
                ),
              ),
            ),
            style: TextStyle(
              color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
            ),
            onChanged: (value) {
              setState(() {}); // Rebuild to update the product list
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
            onPressed: () {
              // Handle cart action
            },
          ),
        ],
      ),
      backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
      body: Column(
        children: [
          // Show category dropdown only if "Brand New" tab is selected
          if (_tabController.index == 2)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Flexible(
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      dropdownColor: themeNotifier.isDarkMode
                          ? Colors.black
                          : Colors.white,
                      style: TextStyle(
                          color: themeNotifier.isDarkMode
                              ? Colors.white
                              : Colors.black),
                      isExpanded: true,
                      items: <String>[
                        'Categories Available - All',
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
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: DropdownButton<String>(
                      value: _selectedPriceRange,
                      dropdownColor: themeNotifier.isDarkMode
                          ? Colors.black
                          : Colors.white,
                      style: TextStyle(
                          color: themeNotifier.isDarkMode
                              ? Colors.white
                              : Colors.black),
                      isExpanded: true,
                      items: <String>[
                        'Price Ranges - All',
                        '0-5',
                        '6-10',
                        '11-15',
                        '16-20',
                        '> 20'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPriceRange = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          // Tab Navigation
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    isScrollable: true, // Allow tabs to scroll
                    indicatorColor: Colors.green,
                    labelColor: Colors.green,
                    unselectedLabelColor: themeNotifier.isDarkMode
                        ? Colors.white70
                        : Colors.black54,
                    tabs: [
                      Tab(text: 'Top Picks'),
                      Tab(text: 'Free Items'),
                      Tab(text: 'Brand New'),
                      Tab(text: 'Used'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildProductGrid(context),
                        _buildProductGrid(context),
                        _buildProductGridFromFirestore(context),
                        _buildProductGrid(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
        unselectedItemColor:
            themeNotifier.isDarkMode ? Colors.white : Colors.black,
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              size: 40,
              color: _selectedIndex == 2 ? Colors.green : Colors.grey,
            ),
            label: 'Buy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    var themeNotifier =
        Provider.of<ThemeNotifier>(context); // Get ThemeNotifier

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7, // Adjusted to prevent overflow
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Card(
          color: themeNotifier.isDarkMode ? Colors.white10 : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/product1.png',
                  height: 150, width: double.infinity, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Name $index',
                      style: TextStyle(
                          color: themeNotifier.isDarkMode
                              ? Colors.white
                              : Colors.black),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: themeNotifier.isDarkMode
                                ? Colors.yellow
                                : Colors.orange,
                            size: 14),
                        Icon(Icons.star,
                            color: themeNotifier.isDarkMode
                                ? Colors.yellow
                                : Colors.orange,
                            size: 14),
                        Icon(Icons.star,
                            color: themeNotifier.isDarkMode
                                ? Colors.yellow
                                : Colors.orange,
                            size: 14),
                        Icon(Icons.star,
                            color: themeNotifier.isDarkMode
                                ? Colors.yellow
                                : Colors.orange,
                            size: 14),
                        Icon(Icons.star,
                            color: themeNotifier.isDarkMode
                                ? Colors.yellow
                                : Colors.orange,
                            size: 14),
                        SizedBox(width: 5),
                        Text(
                          '($index)',
                          style: TextStyle(
                              color: themeNotifier.isDarkMode
                                  ? Colors.white70
                                  : Colors.black87),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      '\$$index.00',
                      style: TextStyle(
                          color: themeNotifier.isDarkMode
                              ? Colors.green
                              : Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductGridFromFirestore(BuildContext context) {
    var themeNotifier =
        Provider.of<ThemeNotifier>(context); // Get ThemeNotifier

    return StreamBuilder<List<AddProduct>>(
      stream: _firebaseService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text('No products found',
                  style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white
                          : Colors.black)));
        }

        //all the products taken from the list of added products are being saved with a variable
        var products = snapshot.data!;

        if (_selectedCategory != 'Categories Available - All') {
          products = products
              .where((product) => product.category == _selectedCategory)
              .toList();
        }

        // Filter by price range
        if (_selectedPriceRange != 'Price Ranges - All') {
          if (_selectedPriceRange.contains('-')) {
            final priceRange = _selectedPriceRange.split('-');
            final minPrice = double.tryParse(priceRange[0]) ?? 0;
            final maxPrice = double.tryParse(priceRange[1]) ?? double.infinity;
            products = products.where((product) {
              final productPrice = double.tryParse(product.price) ?? 0;
              return productPrice >= minPrice && productPrice <= maxPrice;
            }).toList();
          } else if (_selectedPriceRange == '> 20') {
            final minPrice = 20.01;
            products = products.where((product) {
              final productPrice = double.tryParse(product.price) ?? 0;
              return productPrice > minPrice;
            }).toList();
          }
        }

        // Search Function
        final searchQuery = _searchController.text.toLowerCase();
        if (searchQuery.isNotEmpty) {
          products = products
              .where(
                  (product) => product.name.toLowerCase().contains(searchQuery))
              .toList();
        }

        // Sort products by latest first, either edited or newly added products first
        products.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7, // Adjusted to prevent overflow
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  var product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product),
                        ),
                      );
                    },
                    child: Card(
                      color: themeNotifier.isDarkMode
                          ? Colors.white10
                          : Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          product.imageUrl.isNotEmpty
                              ? Image.network(product.imageUrl,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover)
                              : Image.asset('images/product1.png',
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                      color: themeNotifier.isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: themeNotifier.isDarkMode
                                            ? Colors.yellow
                                            : Colors.orange,
                                        size: 14),
                                    Icon(Icons.star,
                                        color: themeNotifier.isDarkMode
                                            ? Colors.yellow
                                            : Colors.orange,
                                        size: 14),
                                    Icon(Icons.star,
                                        color: themeNotifier.isDarkMode
                                            ? Colors.yellow
                                            : Colors.orange,
                                        size: 14),
                                    Icon(Icons.star,
                                        color: themeNotifier.isDarkMode
                                            ? Colors.yellow
                                            : Colors.orange,
                                        size: 14),
                                    Icon(Icons.star,
                                        color: themeNotifier.isDarkMode
                                            ? Colors.yellow
                                            : Colors.orange,
                                        size: 14),
                                    SizedBox(width: 5),
                                    Text(
                                      '(5)', // Placeholder for ratings count
                                      style: TextStyle(
                                          color: themeNotifier.isDarkMode
                                              ? Colors.white70
                                              : Colors.black87),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                      color: themeNotifier.isDarkMode
                                          ? Colors.green
                                          : Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total Products: ${products.length}',
                style: TextStyle(
                    color:
                        themeNotifier.isDarkMode ? Colors.white : Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
