import 'package:eco_unity_flutter_app/firebase_options.dart';
import 'package:eco_unity_flutter_app/firebase_service.dart';
import 'package:eco_unity_flutter_app/screens/account.dart';
import 'package:eco_unity_flutter_app/screens/added.dart';
import 'package:eco_unity_flutter_app/screens/addproduct.dart';
import 'package:eco_unity_flutter_app/screens/addspecs.dart';
import 'package:eco_unity_flutter_app/screens/applelist.dart';
import 'package:eco_unity_flutter_app/screens/applespecification.dart';
import 'package:eco_unity_flutter_app/screens/bought.dart';
import 'package:eco_unity_flutter_app/screens/home.dart';
import 'package:eco_unity_flutter_app/screens/learn.dart';
import 'package:eco_unity_flutter_app/screens/map.dart';
import 'package:eco_unity_flutter_app/screens/sell.dart';
import 'package:eco_unity_flutter_app/screens/signin.dart';
import 'package:eco_unity_flutter_app/screens/specification.dart';
import 'package:eco_unity_flutter_app/screens/updatepassword.dart';
import 'package:flutter/material.dart';
import 'package:eco_unity_flutter_app/screens/signup.dart';
import 'package:eco_unity_flutter_app/screens/signupemail.dart';
import 'package:eco_unity_flutter_app/screens/learnarticle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:eco_unity_flutter_app/screens/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GetIt.instance.registerLazySingleton(() => FirebaseService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
          title: 'EcoUnity',
          theme: theme.getTheme(),
          home: SignupScreen(),
          debugShowCheckedModeBanner: false,
          routes: {
            SignupScreen.routeName: (_) => SignupScreen(),
            SignupemailScreen.routeName: (_) => SignupemailScreen(),
            SigninScreen.routeName: (_) => SigninScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
            SpecificationScreen.routeName: (_) => SpecificationScreen(),
            LearnScreen.routeName: (_) => LearnScreen(),
            LearnArticleScreen.routeName: (_) => LearnArticleScreen(),
            AccountScreen.routeName: (_) => AccountScreen(),
            SellScreen.routeName: (_) => SellScreen(),
            AddproductScreen.routeName: (_) => AddproductScreen(),
            AddspecsScreen.routeName: (_) => AddspecsScreen(),
            AddedScreen.routeName: (_) => AddedScreen(),
            MapScreen.routeName: (_) => MapScreen(),
            AppleListScreen.routeName: (_) => AppleListScreen(),
            Applespecification.routeName: (_) => Applespecification(),
            BoughtScreen.routeName: (_) => BoughtScreen(),
          },
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('App Name'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, SignupScreen.routeName);
          },
          child: const Text('Go to Signup'),
        ),
      ),
    );
  }
}
