import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mood_match/services/firestore_manager.dart';

import '../services/cloud_storage_manager.dart';
import '../services/select_image.dart';
import 'package:mood_match/models/SingletonUser.dart';

class PreRegisterScreen extends StatefulWidget {
  @override
  _PreRegisterScreenState createState() => _PreRegisterScreenState();
}

class _PreRegisterScreenState extends State<PreRegisterScreen> {
  File? profile_image;
  final _nameController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: profile_image != null
                    ? FileImage(profile_image!)
                    : NetworkImage(user!.photoURL!) as ImageProvider<Object>, // Cambio aquí
                child: const Icon(
                  Icons.camera_alt,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre de usuario'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String urlProfileImage = user!.photoURL!;
                if(profile_image!=null){
                  urlProfileImage = await uploadProfileImage(profile_image!, user!.uid);
                }

                savePreRegister(_nameController.text, urlProfileImage);
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/register');
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final image = await getImage();
    if (image != null) {
      setState(() {
        profile_image = File(image.path);
      });
    }
  }
}
