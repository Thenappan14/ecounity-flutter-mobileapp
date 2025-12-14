// import 'package:eco_unity_flutter_app/screens/addspecs.dart';
// import 'package:flutter/material.dart';

// class AddproductScreen extends StatefulWidget {
//   static String routeName = '/addproduct';

//   @override
//   _AddproductScreenState createState() => _AddproductScreenState();
// }

// class _AddproductScreenState extends State<AddproductScreen> {
//   bool isMaggiSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: Icon(Icons.close),
//           color: Colors.white,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Center(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Recents',
//                 style: TextStyle(color: Colors.white),
//               ),
//               Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.white,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.photo_library, color: Colors.white),
//             onPressed: () {
//               // Handle photo library action
//             },
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
//               'Recents',
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//             SizedBox(height: 10),
//             Container(
//               height: 100,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   _buildRecentItem('images/ketchup.png'),
//                   _buildRecentItem('images/capsicum.png'),
//                   _buildRecentItem('images/maggi.png', isMaggi: true),
//                   _buildRecentItem('images/preggo.png'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRecentItem(String imagePath, {bool isMaggi = false}) {
//     return GestureDetector(
//       onTap: () {
//         if (isMaggi) {
//           setState(() {
//             isMaggiSelected = true;
//           });
//           showModalBottomSheet(
//             context: context,
//             builder: (BuildContext context) {
//               return buildBottomNextButton();
//             },
//           );
//         }
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 5),
//         child: Stack(
//           children: [
//             Image.asset(imagePath, height: 100, width: 100),
//             if (isMaggi && isMaggiSelected)
//               Positioned(
//                 top: 5,
//                 right: 5,
//                 child: Icon(Icons.check_circle, color: Colors.green),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildBottomNextButton() {
//     return Container(
//       color: Colors.grey[900],
//       child: Container(
//         margin: EdgeInsets.all(16.0),
//         width: double.infinity,
//         color: Colors.green,
//         child: TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => AddspecsScreen()),
//             );
//           },
//           child: Text(
//             'Next(1)',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }


//--------------------------------------------------------------------original-------------------------------------------------------------------


import 'package:eco_unity_flutter_app/screens/addspecs.dart';
import 'package:flutter/material.dart';

class AddproductScreen extends StatefulWidget {
  static String routeName = '/addproduct';

  @override
  _AddproductScreenState createState() => _AddproductScreenState();
}

class _AddproductScreenState extends State<AddproductScreen> {
  bool isMaggiSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Recents',
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_library, color: Colors.white),
            onPressed: () {
              // Handle photo library action
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recents',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildRecentItem('images/ketchup.png'),
                  _buildRecentItem('images/capsicum.png'),
                  _buildRecentItem('images/maggi.png', isMaggi: true),
                  _buildRecentItem('images/preggo.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentItem(String imagePath, {bool isMaggi = false}) {
    return GestureDetector(
      onTap: () {
        if (isMaggi) {
          setState(() {
            isMaggiSelected = true;
          });
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return buildBottomNextButton();
            },
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            Image.asset(imagePath, height: 100, width: 100),
            if (isMaggi && isMaggiSelected)
              Positioned(
                top: 5,
                right: 5,
                child: Icon(Icons.check_circle, color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNextButton() {
    return Container(
      color: Colors.grey[900],
      child: Container(
        margin: EdgeInsets.all(16.0),
        width: double.infinity,
        color: Colors.green,
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddspecsScreen()),
            );
          },
          child: Text(
            'Next(1)',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
