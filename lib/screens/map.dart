import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  static String routeName = '/map';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  TextEditingController _searchController = TextEditingController();
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};

  Future<void> _performSearch(String query) async {
    print('Performing search for: $query');
    final apiKey = 'AIzaSyD_6NJT5m0gHRNoEGtttY_G8M7QzOnzpMs';
    final url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      print('HTTP Response Status Code: ${response.statusCode}');

      // Check if the request was successful
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('API Response Data: $data');

        // Check if the response contains results
        if (data['results'] != null && data['results'].isNotEmpty) {
          setState(() {
            _markers.clear();
            for (var result in data['results']) {
              final location = result['geometry']['location'];
              final lat = location['lat'];
              final lng = location['lng'];
              final placeName = result['name'];
              final placeAddress = result['formatted_address'];

              print(
                  'Place: $placeName, Address: $placeAddress, Latitude: $lat, Longitude: $lng');

              _markers.add(
                Marker(
                  markerId: MarkerId(placeName),
                  position: LatLng(lat, lng),
                  infoWindow: InfoWindow(
                    title: placeName,
                    snippet: placeAddress,
                  ),
                ),
              );
            }
          });

          // Move the camera to the first result-home location
          final firstLocation = data['results'][0]['geometry']['location'];
          print(
              'Moving camera to: Latitude: ${firstLocation['lat']}, Longitude: ${firstLocation['lng']}');
          _mapController.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(firstLocation['lat'], firstLocation['lng']),
              14,
            ),
          );
        } else {
          print('No results found for $query');
        }
      } else {
        print('Failed to load data, status code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error during search: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Marker> markerList = const [
      Marker(
        markerId: MarkerId('Your Location'),
        position: LatLng(1.3613775632110368, 103.9411666246169),
        infoWindow: InfoWindow(
          title: 'Home',
          snippet: '5 Star Rating',
        ),
      ),
      Marker(
        markerId: MarkerId('Thomas'),
        position: LatLng(1.362776360547922, 103.94023817993855),
        infoWindow: InfoWindow(
          title: 'Burger',
          snippet: '5 Star Rating',
        ),
      ),
      Marker(
        markerId: MarkerId('Marco'),
        position: LatLng(1.3611201438186071, 103.93964312995618),
        infoWindow: InfoWindow(
          title: 'Vegetables',
          snippet: '4 Star Rating',
        ),
      ),
      Marker(
        markerId: MarkerId('Ryan'),
        position: LatLng(1.3632116755861785, 103.94234679653717),
        infoWindow: InfoWindow(
          title: 'Medicine A',
          snippet: '3 Star Rating',
        ),
      ),
    ];

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
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a place...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    print('Search query submitted: $query'); // Debugging print
                    _performSearch(query);
                  } else {
                    print('Search query is empty');
                  }
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                String query = _searchController.text;
                if (query.isNotEmpty) {
                  print('Search button pressed: $query'); // Debugging print
                  _performSearch(query);
                } else {
                  print('Search query is empty');
                }
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
              print('Map created'); // Debugging print
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  1.3613775632110368, 103.9411666246169), // Initial position
              zoom: 17, // Set higher zoom level
            ),
            mapType: MapType.normal, // Set map type to normal
            markers: _markers.union(markerList
                .toSet()), // Combine search markers with predefined markers
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              child: Icon(Icons.location_searching),
              onPressed: () async {
                // Assuming the initial marker position is your target location
                final position = LatLng(1.3613775632110368, 103.9411666246169);
                _mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: position,
                      zoom: 18, // Set higher zoom level
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
