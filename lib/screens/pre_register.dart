import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mood_match/services/firestore_manager.dart';

import '../models/SingletonUser.dart';
import '../services/cloud_storage_manager.dart';
import '../services/select_image.dart';

class PreRegisterScreen extends StatefulWidget {
  const PreRegisterScreen({super.key});

  @override
  State<PreRegisterScreen> createState() => _PreRegisterScreenState();
}

class _PreRegisterScreenState extends State<PreRegisterScreen> {
  File? profileImage;
  final _nameController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: profileImage != null
                    ? FileImage(profileImage!)
                    : NetworkImage(user!.photoURL!) as ImageProvider<Object>,
                child: const Icon(
                  Icons.camera_alt,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _nameController,
                decoration:
                    const InputDecoration(labelText: 'Nombre de usuario'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String urlProfileImage = user!.photoURL!;
                if (profileImage != null) {
                  urlProfileImage =
                      await uploadProfileImage(profileImage!, user!.uid);
                }

                savePreRegister(
                    _nameController.text, urlProfileImage, user!.email!);
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

  Future<void> pickImage() async {
    final image = await getImage();
    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  void savePreRegister(String username, String profileImageUrl, String email) {
    UserSingleton().username = username;
    UserSingleton().profileImageUrl = profileImageUrl;
    UserSingleton().email = email;
  }
}
