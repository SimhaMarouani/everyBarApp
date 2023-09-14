import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

// Custom TextInputFormatter to enforce hour format (HH:mm)
  final _hourFormatter = FilteringTextInputFormatter(
    RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$'),
    allow: true,
    replacementString: '',
  );

  @override
  void initState() {
    super.initState();

    // Apply the custom formatter to the opening and closing hour controllers
    _openingHourController
        .addListener(() => _applyFormatter(_openingHourController));
    _closingHourController
        .addListener(() => _applyFormatter(_closingHourController));
  }

  void _applyFormatter(TextEditingController controller) {
    final text = controller.text;
    final formattedText = _formatHour(text);
    if (text != formattedText) {
      controller.value = controller.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  String _formatHour(String text) {
    if (text.isEmpty) return text;

    final parts = text.split(':');
    if (parts.length != 2) return text;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) return text;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return text;

    return '$hour:${minute.toString().padLeft(2, '0')}';
  }

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
