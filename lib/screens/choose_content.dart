import 'package:flutter/material.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _selectType('music');
              },
              child: Text('Música'),
            ),
            ElevatedButton(
              onPressed: () {
                _selectType('movie');
              },
              child: Text('Películas'),
            ),
            ElevatedButton(
              onPressed: () {
                _selectType('serie');
              },
              child: Text('Series'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedType != null) {
                  _navigateToChooseEmotion(context, selectedType!);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Por favor, selecciona un tipo de contenido.'),
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
              child: Text('Siguiente'),
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
