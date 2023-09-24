import 'package:flutter/material.dart';
import 'package:mood_match/main.dart';
class ChooseContent extends StatefulWidget {
  @override
  _ChooseContentState createState() => _ChooseContentState();
}

class _ChooseContentState extends State<ChooseContent> {
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona el Contenido'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 100), // Espacio encima del primer boton
          _buildContentButton('Música', 'assets/images/music.png', 'music'),
          SizedBox(height: 16), // Espacio vertical entre botones
          _buildContentButton('Películas', 'assets/images/movie.png', 'movie'),
          SizedBox(height: 16), // Espacio vertical entre botones
          _buildContentButton('Series', 'assets/images/serie.png', 'serie'),
          // Agrega más botones si es necesario
        ],
      ),
    );
  }

  Widget _buildContentButton(String text, String imagePath, String type) {
    return Container(
      width: double.infinity, // Ocupa toda la anchura disponible
      height: 150, // Tamaño cuadrado del botón
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: MyApp.customSwatch, // Color de fondo del botón
      ),
      child: ElevatedButton(
        onPressed: () {
          _selectType(type);
          _navigateToChooseEmotion(context, type);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent, // Fondo transparente
          elevation: 0, // Sin sombra
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido verticalmente
          children: [
            Image.asset(
              imagePath,
              width: 80, // Ajusta el tamaño de la imagen para que sea cuadrada
              height: 80, // Ajusta el tamaño de la imagen para que sea cuadrada
            ),
            SizedBox(height: 8), // Espacio vertical entre imagen y texto
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectType(String type) {
    setState(() {
      selectedType = type;
    });
  }

  void _navigateToChooseEmotion(BuildContext context, String type) {
    Navigator.pushNamed(
      context,
      '/choose_emotion',
      arguments: {
        'type': type,
      },
    );
  }
}
