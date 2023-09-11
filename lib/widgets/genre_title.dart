import 'package:flutter/material.dart';

class GenreTile extends StatelessWidget {
  final String genre;
  final bool isSelected;
  final void Function(bool)? onSelected;

  GenreTile({
    required this.genre,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath = 'assets/imagen_${genre.toLowerCase()}.png';

    return InkWell(
      onTap: () {
        if (onSelected != null) {
          onSelected!(!isSelected);
        }
      },
      child: Card(
        color: isSelected ? Colors.blue : Colors.white,
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath ?? 'assets/images/defaultMovie.jpg',
              width: 80.0,
              height: 80.0,
            ),
            SizedBox(height: 8.0),
            Text(genre),
          ],
        ),
      ),
    );
  }
}
