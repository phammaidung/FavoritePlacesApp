import 'package:favorite_places_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location = const PlaceLocation(
          latitude: 37.422, longtitude: -122.084, address: ''),
      this.isSelecting = true});

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your location' : 'Your location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {},
            )
        ],
      ),
      body:

          /// using FlutterMap instead of GooggleMap package.
          FlutterMap(
        options: MapOptions(
          onTap: (tapPosition, point) {
            setState(() {
              _pickedLocation = point;
            });
          },
          center: LatLng(widget.location.latitude, widget.location.longtitude),
          zoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://{s}-tiles.locationiq.com/v3/streets/r/{z}/{x}/{y}.png?key=pk.dabbb7c5ff00c75b70bed3798994c6a9',
            //'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', //alternative template for map
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: _pickedLocation == null && widget.isSelecting
                ? []
                : [
                    Marker(
                        point: _pickedLocation ??
                            LatLng(widget.location.latitude,
                                widget.location.longtitude),
                        builder: (ctx) => const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            )),
                  ],
          ),
        ],
      ),
    );
  }
}
