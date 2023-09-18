import 'package:flutter/material.dart';
import 'package:mood_match/controllers/login.dart';
import 'package:mood_match/screens/home.dart'; // Asegúrate de utilizar la ruta correcta hacia tu archivo controllers/login.dart

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;

                  // Llama a la función loginUser para verificar el inicio de sesión
                  bool loginSuccessful = await loginUser(email, password);

                  if (loginSuccessful) {
                    // Si el inicio de sesión es exitoso, navega a la siguiente página
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(), // Reemplaza NextPage con el nombre de tu siguiente página
                      ),
                    );
                  } else {
                    // Si el inicio de sesión falla, muestra un mensaje de error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: Correo o contraseña incorrectos'),
                      ),
                    );

                    // Puedes borrar el texto de los campos de correo y contraseña si lo deseas
                    emailController.clear();
                    passwordController.clear();
                  }
                },
                child: const Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
