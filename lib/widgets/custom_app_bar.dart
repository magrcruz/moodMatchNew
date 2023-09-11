import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);
  static const MaterialColor customSwatch = MaterialColor(
    0xFFBF2828, // Valor principal (el color que deseas)
    <int, Color>{
      50: Color(0xFFFFEDED),
      100: Color(0xFFFFCBCB),
      200: Color(0xFFFFA8A8),
      300: Color(0xFFFF8585),
      400: Color(0xFFFF6F6F),
      500: Color(0xFFBF2828), // Valor principal
      600: Color(0xFFA82323),
      700: Color(0xFF931E1E),
      800: Color(0xFF7A1919),
      900: Color(0xFF5E1414),
    },
  );
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 50,
          ),
          SizedBox(width: 8),
          Text(
            'MOOD MATCH',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
      backgroundColor: customSwatch,
      actions: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print("Presionaste el botón de ajustes"); // Agrega este registro
            Navigator.pushNamed(context, '/index'); // Navega a la ruta '/index'
          },
        ),
      ],
    );
  }
}
