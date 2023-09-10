import 'package:favorite_places_app/screens/new_place.dart';
import 'package:favorite_places_app/screens/place_detail.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';

class FavoritePlacesScreen extends StatefulWidget {
  const FavoritePlacesScreen({super.key});

  @override
  State<FavoritePlacesScreen> createState() => _FavoritePlacesScreenState();
}

class _FavoritePlacesScreenState extends State<FavoritePlacesScreen> {
  final List<Place> _favoritePlaces = [];

  void _addPlace() async {
    final newPlace = await Navigator.of(context)
        .push<Place>(MaterialPageRoute(builder: (ctx) => const NewPlace()));
    setState(() {
      _favoritePlaces.add(newPlace!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: _favoritePlaces.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>
                      PlaceDetailScreen(place: _favoritePlaces[index])));
            },
            child: Text(_favoritePlaces[index].title),
          );
        });

    if (_favoritePlaces.isEmpty) {
      content = Center(
        child: Text('No place added yet.',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer)),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(onPressed: _addPlace, icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
