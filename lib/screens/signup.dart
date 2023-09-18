import 'package:flutter/material.dart';
import 'package:mood_match/controllers/signup.dart';

class SignUp extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final SignUpController _signUpController = SignUpController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombres',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Apellidos',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                ),
              ),
              const SizedBox(height: 16.0),
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
              const SizedBox(height: 16.0),
              TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Contraseña',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String firstName = firstNameController.text;
                  String lastName = lastNameController.text;
                  String username = usernameController.text;
                  String email = emailController.text;
                  String password = passwordController.text;
                  String confirmPassword = confirmPasswordController.text;

                  // Validar que las contraseñas coincidan antes de registrar al usuario.
                  if (password == confirmPassword) {
                    // Realizar el registro del usuario utilizando el controlador SignUpController.
                    bool registrationSuccess = await _signUpController.signUp(email, password, firstName, lastName, username);

                    if (registrationSuccess) {
                      // Registro exitoso, puedes manejar la navegación o mostrar un mensaje de éxito.
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Registro Exitoso'),
                            content: const Text('El usuario ha sido registrado correctamente.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Registro fallido, muestra un mensaje de error.
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Hubo un problema al registrar el usuario.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    // Las contraseñas no coinciden, muestra un mensaje de error.
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Las contraseñas no coinciden.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cerrar'),
                            ),
                          ],
                        );
                      },
                    );
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
}
