import 'package:flutter/material.dart';

class ChooseContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona el Contenido'),
      ),
      body: ListView(
        children: <Widget>[
          ResultItem(title: 'Resultado 1'),
          ResultItem(title: 'Resultado 2'),
          ResultItem(title: 'Resultado 3'),
          // Puedes agregar más elementos de lista de resultados aquí
        ],
      ),
    );
  }
}

class ResultItem extends StatelessWidget {
  final String title;

  ResultItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        // Agrega aquí la lógica para manejar la selección del resultado
      },
    );
  }
}
