// import 'package:flutter/material.dart';

// class AppleListScreen extends StatefulWidget {
//   static String routeName = '/applelist';

//   @override
//   _AppleListScreenState createState() => _AppleListScreenState();
// }

// class _AppleListScreenState extends State<AppleListScreen> {
//   final List<Map<String, String>> appleList = [
//     {
//       'image': 'images/apple1.png',
//       'time': '1 day ago',
//       'name': 'China Fuji apples',
//       'price': 'S\$2 - New',
//       'location': '@thenosisawesome'
//     },
//     {
//       'image': 'images/apple1.png',
//       'time': '20 hours ago',
//       'name': 'Envy Apples',
//       'price': 'New Zealand S\$4 - New',
//       'location': '@welcometoseanshops'
//     },
//     {
//       'image': 'images/apple1.png',
//       'time': '12 hours ago',
//       'name': 'Kanzi Apple Australia',
//       'price': 'S\$5 for 4pcs - New',
//       'location': '@mumskitchen!!'
//     },
//     {
//       'image': 'images/apple1.png',
//       'time': '12 hours ago',
//       'name': 'Pear Fragrant Punnet',
//       'price': 'China S\$4.70 - New',
//       'location': '@littlesayang'
//     },
//     {
//       'image': 'images/apple1.png',
//       'time': '8 hours ago',
//       'name': 'Royal Gala Apple - 900g',
//       'price': 'S\$4 - New',
//       'location': '@mumskitchen!!'
//     },
//     {
//       'image': 'images/apple1.png',
//       'time': '2 hours ago',
//       'name': 'Nam Shui Pears 2s',
//       'price': 'S\$6 - New',
//       'location': '@traaaalewhale'
//     },
//   ];

//   late List<bool> favorites;

//   @override
//   void initState() {
//     super.initState();
//     favorites = List<bool>.filled(appleList.length, false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: TextField(
//           style: TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             hintText: 'Apples',
//             hintStyle: TextStyle(color: Colors.white54),
//             border: InputBorder.none,
//             icon: Icon(Icons.search, color: Colors.white),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.shopping_cart, color: Colors.white),
//             onPressed: () {
//               // Handle cart action
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.more_vert, color: Colors.white),
//             onPressed: () {
//               // Handle more options
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '50+ results in Singapore',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Chip(
//                     label:
//                         Text('Fruits', style: TextStyle(color: Colors.white)),
//                     backgroundColor: Colors.grey[800],
//                   ),
//                   SizedBox(width: 10),
//                   Chip(
//                     label:
//                         Text('Apples', style: TextStyle(color: Colors.white)),
//                     backgroundColor: Colors.grey[800],
//                   ),
//                   Spacer(),
//                   TextButton.icon(
//                     onPressed: () {
//                       // Handle filter action
//                     },
//                     icon: Icon(Icons.filter_list, color: Colors.white),
//                     label:
//                         Text('Filter', style: TextStyle(color: Colors.white)),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: appleList.length,
//                 itemBuilder: (context, index) {
//                   final apple = appleList[index];
//                   return Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[900],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Stack(
//                           children: [
//                             Center(
//                               child: Image.asset(
//                                 apple['image'] ?? 'images/default.png',
//                                 fit: BoxFit.cover,
//                                 width: 100,
//                                 height: 100,
//                               ),
//                             ),
//                             Positioned(
//                               right: 0,
//                               child: IconButton(
//                                 icon:
//                                     Icon(Icons.more_vert, color: Colors.white),
//                                 onPressed: () {
//                                   // Handle more options
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   apple['time'] ?? '',
//                                   style: TextStyle(
//                                       color: Colors.white54, fontSize: 12),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   apple['name'] ?? '',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             apple['price'] ?? '',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 14),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Text(
//                                             apple['location'] ?? '',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 14),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(
//                                         favorites[index]
//                                             ? Icons.favorite
//                                             : Icons.favorite_border,
//                                         color: favorites[index]
//                                             ? Colors.red
//                                             : Colors.white,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           favorites[index] = !favorites[index];
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 4),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:eco_unity_flutter_app/screens/applespecification.dart';
import 'package:flutter/material.dart';

class AppleListScreen extends StatefulWidget {
  static String routeName = '/applelist';

  @override
  _AppleListScreenState createState() => _AppleListScreenState();
}

class _AppleListScreenState extends State<AppleListScreen> {
  final List<Map<String, String>> appleList = [
    {
      'image': 'images/apple1.png',
      'time': '1 day ago',
      'name': 'China Fuji apples',
      'price': 'S\$2 - New',
      'location': '@thenosisawesome'
    },
    {
      'image': 'images/apple1.png',
      'time': '20 hours ago',
      'name': 'Envy Apples',
      'price': 'New Zealand S\$4 - New',
      'location': '@welcometoseanshops'
    },
    {
      'image': 'images/apple1.png',
      'time': '12 hours ago',
      'name': 'Kanzi Apple Australia',
      'price': 'S\$5 for 4pcs - New',
      'location': '@mumskitchen!!'
    },
    {
      'image': 'images/apple1.png',
      'time': '12 hours ago',
      'name': 'Pear Fragrant Punnet',
      'price': 'China S\$4.70 - New',
      'location': '@littlesayang'
    },
    {
      'image': 'images/apple1.png',
      'time': '8 hours ago',
      'name': 'Royal Gala Apple - 900g',
      'price': 'S\$4 - New',
      'location': '@mumskitchen!!'
    },
    {
      'image': 'images/apple1.png',
      'time': '2 hours ago',
      'name': 'Nam Shui Pears 2s',
      'price': 'S\$6 - New',
      'location': '@traaaalewhale'
    },
  ];

  late List<bool> favorites;

  @override
  void initState() {
    super.initState();
    favorites = List<bool>.filled(appleList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Apples',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              // Handle cart action
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '50+ results in Singapore',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Chip(
                    label:
                        Text('Fruits', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.grey[800],
                  ),
                  SizedBox(width: 10),
                  Chip(
                    label:
                        Text('Apples', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.grey[800],
                  ),
                  Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      // Handle filter action
                    },
                    icon: Icon(Icons.filter_list, color: Colors.white),
                    label:
                        Text('Filter', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: appleList.length,
                itemBuilder: (context, index) {
                  final apple = appleList[index];
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Navigator.pushNamed(
                            context, Applespecification.routeName);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: Image.asset(
                                  apple['image'] ?? 'images/default.png',
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                  icon: Icon(Icons.more_vert,
                                      color: Colors.white),
                                  onPressed: () {
                                    // Handle more options
                                  },
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    apple['time'] ?? '',
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 12),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    apple['name'] ?? '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              apple['price'] ?? '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              apple['location'] ?? '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          favorites[index]
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: favorites[index]
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            favorites[index] =
                                                !favorites[index];
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
