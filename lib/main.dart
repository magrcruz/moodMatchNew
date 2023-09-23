/*import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'routes/routes.dart'; // Importa tus rutas desde routes.dart


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Define un MaterialColor personalizado
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
    return MaterialApp(
      title: 'Mood Match',
      theme: ThemeData(
        primarySwatch: customSwatch, // Usa el MaterialColor personalizado
        fontFamily: 'Raleway',
      ),
      initialRoute: '/splash', // Establece la ruta inicial en '/index'
      routes: routes, // Utiliza las rutas definidas en routes.dart
    );
  }
}

