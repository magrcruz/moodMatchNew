import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'Nombres',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Apellidos',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes implementar la lógica para registrar al usuario.
                  String firstName = firstNameController.text;
                  String lastName = lastNameController.text;
                  String username = usernameController.text;
                  String email = emailController.text;
                  String password = passwordController.text;
                  String confirmPassword = confirmPasswordController.text;
                  
                  // Validar que las contraseñas coincidan antes de registrar al usuario.
                  if (password == confirmPassword) {
                    // Realizar el registro del usuario aquí.
                    print('Nombres: $firstName');
                    print('Apellidos: $lastName');
                    print('Usuario: $username');
                    print('Correo Electrónico: $email');
                    print('Contraseña: $password');
                    // Puedes continuar con el proceso de registro.
                  } else {
                    // Las contraseñas no coinciden, muestra un mensaje de error.
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Las contraseñas no coinciden.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cerrar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
