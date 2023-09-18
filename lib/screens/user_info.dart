import 'package:flutter/material.dart';
import 'package:mood_match/controllers/user_info.dart';
import 'package:mood_match/models/user_profile.dart';

class UserProfileScreen extends StatefulWidget {
  final String userEmail; // Correo electrónico del usuario

  UserProfileScreen({required this.userEmail});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserProfile _userInfo; // Variable para almacenar la información del usuario

  @override
  void initState() {
    super.initState();
    // Cuando se carga la pantalla, llama a la función para obtener la información del usuario
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final UserInfoController userInfoController = UserInfoController();
      final UserProfile? userInfo = await userInfoController.getUserProfileByEmail(widget.userEmail);

      if (userInfo != null) {
        // Actualiza el estado con la información del usuario obtenida
        setState(() {
          _userInfo = userInfo;
        });
      } else {
        // Maneja el caso en el que el usuario no exista en la base de datos
        print('El usuario no existe en la base de datos.');
      }
    } catch (e) {
      // Manejar cualquier error que ocurra al obtener la información del usuario
      print('Error al cargar la información del usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
      ),
      backgroundColor: Colors.white, // Establece un fondo blanco para el Scaffold
      body: _userInfo != null // Verifica si la información del usuario está disponible
          ? UserProfileWidget(userInfo: _userInfo) // Muestra UserProfileWidget con la información
          : Center(child: CircularProgressIndicator()), // Muestra un indicador de carga si aún no se ha cargado la información
    );
  }
}
