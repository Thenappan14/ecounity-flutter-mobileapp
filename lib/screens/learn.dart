import 'package:eco_unity_flutter_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eco_unity_flutter_app/screens/learnarticle.dart'; // Import the detailed article screen
import 'package:provider/provider.dart';
import 'package:eco_unity_flutter_app/screens/theme_notifier.dart'; // Import ThemeNotifier

class LearnScreen extends StatelessWidget {
  static String routeName = '/learn';

  @override
  Widget build(BuildContext context) {
    var themeNotifier =
        Provider.of<ThemeNotifier>(context); // Get ThemeNotifier

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sustainability',
          style: TextStyle(
            color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
          ), // Set the text color based on theme
        ),
        backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
        ),
      ),
      backgroundColor: themeNotifier.isDarkMode ? Colors.black : Colors.white,
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          // Main image and headline
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LearnArticleScreen.routeName);
            },
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/learnmain.png',
                    height: 200,
                    width: 250,
                  ), // Replace with your main image asset
                  SizedBox(height: 8.0),
                  Text(
                    "Sustainability is a team sport\nhere's why;",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    "10 hours ago",
                    style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white70
                          : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
              color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
          // List of articles
          _buildArticleTile(
            context,
            'Making Treasure out of trash: Firms turn food waste into compost, insect feed',
            'images/article1.png',
            '14 hours ago',
            'https://www.channelnewsasia.com/sustainability/food-waste-segregation-treatment-mbs-digesters-food-recycling-3574461',
            themeNotifier.isDarkMode,
          ),
          Divider(
              color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
          _buildArticleTile(
            context,
            'How much leftover, packaging waste do you generate when you fly?',
            'images/article2.png',
            '2 days ago',
            'https://www.channelnewsasia.com/world/cabin-waste-food-packaging-airlines-passengers-3322141',
            themeNotifier.isDarkMode,
          ),
          Divider(
              color: themeNotifier.isDarkMode ? Colors.white : Colors.black),
          _buildArticleTile(
            context,
            'With Hong Kong running out of space for its trash, residents are doing more to reduce waste',
            'images/article3.png',
            '4 days ago',
            'https://www.channelnewsasia.com/asia/hong-kong-landfills-running-out-space-3217566',
            themeNotifier.isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildArticleTile(BuildContext context, String title, String imagePath,
      String timeAgo, String url, bool isDarkMode) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
      leading:
          Image.asset(imagePath, fit: BoxFit.cover, width: 100, height: 100),
      title: Text(
        title,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        timeAgo,
        style: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black54,
        ),
      ),
      trailing: Icon(Icons.more_vert,
          color: isDarkMode ? Colors.white : Colors.black),
      onTap: () async {
        Uri articleUrl = Uri.parse(url);
        if (await canLaunchUrl(articleUrl)) {
          await launchUrl(articleUrl);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }
}
