import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';

import '../Services/firestore_manager.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu nombre.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu apellido.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: dateController, //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                ),
                readOnly: true,  // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await DatePicker.showSimpleDatePicker(
                    context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    dateFormat: "dd-MMMM-yyyy",
                    locale: DateTimePickerLocale.en_us,
                    looping: true,
                  );
                  if(pickedDate != null ){
                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                    setState(() {
                      dateController.text = formattedDate;
                      _selectedDate = pickedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await registerUser();
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  }
                },
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userData = {
          'name': _nameController.text,
          'last_name': _lastNameController.text,
          'age': Timestamp.fromDate(_selectedDate),
          // Guarda la fecha como Timestamp
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update(userData);

        await fetchAndSetUserData(user.uid);
      }
    } catch (error) {
      print('Error al registrar el usuario: $error');
    }
  }
}
