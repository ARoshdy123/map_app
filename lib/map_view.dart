import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  // Making position to Cairo
  static const CameraPosition _kCairo = CameraPosition(
    target: LatLng(30.0444, 31.2357), // Latitude and Longitude of Cairo, Egypt
    zoom: 12.0, // Set an appropriate zoom level
  );

  // Create a set of markers with a red marker at Cairo
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('cairo_marker'),
      position: LatLng(30.0444, 31.2357), // Cairo coordinates
      infoWindow: InfoWindow(title: 'Cairo, Egypt'),
      icon: BitmapDescriptor.defaultMarker, // Default marker is red
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Map View')),
        backgroundColor: Colors.deepPurple, // AppBar color for better UI
      ),
      body: GoogleMap(
        mapType: MapType.normal, // Use normal map type
        initialCameraPosition: _kCairo,
        markers: _markers, // Add the Cairo marker
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToCairo,
        label: const Text('Go to Cairo'),
        icon: const Icon(Icons.location_city),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  Future<void> _goToCairo() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kCairo));
  }
}
