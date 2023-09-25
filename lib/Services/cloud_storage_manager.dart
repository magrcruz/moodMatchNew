import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage storage = FirebaseStorage.instance;

Future<String> uploadProfileImage(File image, String username) async {
      final Reference ref = storage.ref().child("profile_images").child(username);
      final UploadTask uploadTask = ref.putFile(image);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
      final String url = await snapshot.ref.getDownloadURL();
  return url;
}