// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import '../../services/location_helper.dart';
import '../../data/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({required this.neighborPatients, super.key});
  final List<Patient> neighborPatients;
  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();

    Set<Marker> markers = <Marker>{};
    for (var patient in neighborPatients) {
      markers.add(Marker(
          markerId: MarkerId(patient.id),
          position: LatLng(patient.lat!, patient.long!),
          infoWindow: InfoWindow(title: patient.fullName)));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps'),
          centerTitle: true,
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: LocationHelper.getSavedCurrentLocation(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              markers.add(
                Marker(
                    markerId: const MarkerId('1'),
                    position: LatLng(snapshot.data!['latitude'],
                        snapshot.data!['longitude']!),
                    infoWindow: const InfoWindow(
                      title: 'My Position',
                    )),
              );
              CameraPosition kGooglePlex = CameraPosition(
                target: LatLng(
                    snapshot.data!['latitude'], snapshot.data!['longitude']!),
                zoom: 14.4746,
              );
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: kGooglePlex,
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
