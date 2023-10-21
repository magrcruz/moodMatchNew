import 'package:flutter/material.dart';
import 'package:mood_match/main.dart';
class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(Icons.home),
              label: Text('Página Principal'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                primary: MyApp.customSwatch,

              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/show_info');
              },
              icon: Icon(Icons.info),
              label: Text('Información'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                primary: MyApp.customSwatch,
              ),
            ),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/user_info');
              },
              icon: Icon(Icons.person),
              label: Text('Mi Perfil'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                primary: MyApp.customSwatch,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                //Navigator.pushNamed(context, '/edit_profile');
              },
              icon: Icon(Icons.edit),
              label: Text('Editar Perfil'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                primary: MyApp.customSwatch,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/signout');
              },
              icon: Icon(Icons.exit_to_app),
              label: Text('Salir'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                primary: MyApp.customSwatch,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
