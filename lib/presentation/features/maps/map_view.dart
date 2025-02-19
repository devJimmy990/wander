import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final double ?latitude;
  final double ?longitude;
  final String ?name;

  const MapScreen({
    super.key,
     this.latitude,
     this.longitude,  this.name,
  });

  @override
  Widget build(BuildContext context) {
    final LatLng targetPosition = LatLng(latitude!, longitude!);
    return Scaffold(
      appBar: AppBar(title: Center(child:  Text(" $name Location"  ))),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: targetPosition,
          zoom: 17,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('landmark'),
            position: targetPosition,
          ),
        },
      ),
    );
  }
}
