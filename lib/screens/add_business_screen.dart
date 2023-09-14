import 'package:flutter/material.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({
    super.key,
  });

  @override
  State<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _openingHourController = TextEditingController();
  final TextEditingController _closingHourController = TextEditingController();
  final TextEditingController _kosherController = TextEditingController();
  final TextEditingController _happyHourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Business'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Business Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the business name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _openingHourController,
                decoration: InputDecoration(labelText: 'Opening Hour'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the opening hour';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _closingHourController,
                decoration: InputDecoration(labelText: 'Closing Hour'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the closing hour';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kosherController,
                decoration: InputDecoration(labelText: 'Kosher?'),
                validator: (value) {
                  return null;
                },
              ),
              TextFormField(
                controller: _happyHourController,
                decoration: InputDecoration(labelText: 'Happy Hour?'),
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process and save the business data here
                    // You can access the entered data using _nameController.text, _addressController.text, etc.
                    // Add your logic to save the data to your database or perform any other actions.
                  }
                },
                child: Text('Add Business'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
