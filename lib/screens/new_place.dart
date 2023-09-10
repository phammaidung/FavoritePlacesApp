import 'package:favorite_places_app/models/place.dart';
import 'package:flutter/material.dart';

class NewPlace extends StatefulWidget {
  const NewPlace({super.key});

  @override
  State<NewPlace> createState() {
    return _NewPlaceState();
  }
}

class _NewPlaceState extends State<NewPlace> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';

  void _savePlace() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(Place(title: _enteredTitle));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new place')),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length > 50) {
                    return "Must be between 1 and 50 characters.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredTitle = value!;
                },
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                  onPressed: _savePlace,
                  icon: const Icon(Icons.add),
                  label: const Text('Add place'))
            ],
          )),
    );
  }
}
