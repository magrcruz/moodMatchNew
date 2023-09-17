import 'package:flutter/material.dart';

class GenreTile extends StatelessWidget {
  final String genre;
  final String type;
  final bool isSelected;
  final void Function(bool)? onSelected;

  GenreTile({
    required this.genre,
    required this.type,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = 'assets/images/defaultMovie.png';
    return InkWell(
      onTap: () {
        if (onSelected != null) {
          onSelected!(!isSelected);
        }
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Ajusta el radio de la tarjeta según tus necesidades.
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFEDED), Color(0xFFBF2828)],
                  )
                : null,
            borderRadius: BorderRadius.circular(12.0), // Ajusta el radio de la tarjeta según tus necesidades.
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0), // Ajusta el radio de las esquinas de la imagen.
                child: Image.asset(
                  imagePath,
                  width: 80, // Ajusta el tamaño de la imagen según tus necesidades.
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    // En caso de error al cargar la imagen, muestra la imagen por defecto.
                    return Image.asset(
                      'assets/images/defaultMovie.png',
                      width: 80,
                      height: 80,
                    );
                  },
                ),
              ),
              const SizedBox(height: 5), // Espacio entre la imagen y el texto
              Text(
                genre,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'system-ui', // Cambia la fuente a system ui
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
