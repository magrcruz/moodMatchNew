import 'package:flutter/material.dart';
import 'package:mood_match/controllers/genresClasification.dart';
import 'package:mood_match/widgets/Custom_Loader.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:mood_match/models/contentDetails.dart';
import 'package:mood_match/controllers/recommendations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mood_match/main.dart';
import 'package:mood_match/Models/MovieSerie.dart';

class Details extends StatefulWidget {
  final MovieSerie content;
  final String? id;
  final String? type;
  final String? title;

  Details({required this.content,this.id,this.type, this.title});

  @override
  _DetailsContent createState() => _DetailsContent();
}

class _DetailsContent extends State<Details> {
  ContentDetails? contentDetails;

  @override
  void initState() {
    super.initState();
    fetchContentDetails(widget.content).then((details) {
      setState(() {
        contentDetails = details;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      body: contentDetails != null
          ? Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildImageCard(contentDetails!.imageUrl),
            LikeDislikeWidget(
              details: widget, // Pasa la instancia de Details
            ),
            _buildSectionHeader('Título'),
            _buildSectionContent(widget.title ?? 'Título no disponible'),
            _buildSectionHeader('Género'),
            _buildSectionContent(contentDetails!.genre),
            _buildSectionHeader(widget.type == 'music' ? 'Artista' : 'Sinopsis'),
            _buildSectionContent(contentDetails!.synopsisOrArtist ?? 'Información no disponible'),
            _buildSectionHeader('Plataformas'),
            _buildSectionContent(contentDetails!.platforms.join(', ')),
          ],
        ),
      )
          : Center(child: CustomLoader()),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        content,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

Future<bool> _imageExistsOnline(String imageUrl) async {
  if (imageUrl.isEmpty) {
    return false;
  }
  final Uri uri = Uri.parse(imageUrl);
  if (!uri.isAbsolute) {
    return false;
  }
  try {
    final response = await http.head(uri);
    if (response.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }
  catch (e) {
    return false;
  }
}

Widget _buildImageCard(String imageUrl) {
  return Container(
    height: 200,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FutureBuilder<bool>(
        future: _imageExistsOnline(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Puedes mostrar un indicador de carga mientras se verifica la existencia de la imagen.
          } else if (snapshot.hasError || !snapshot.hasData){
            // Si hay un error, si snapshot.data es nulo o si la imagen no existe en la red, muestra una imagen predeterminada.
            return Image.asset(
              'assets/images/defaultMovie.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            );
          } else {
            // Si la imagen existe en la red, muestra la imagen desde la URL.
            return Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            );
          }
        },
      ),
    ),
  );
}


  Future<ContentDetails> fetchContentDetails(MovieSerie? content) async {
    /*
    try {
      // Llama a extractContentDetailsFromMovie para obtener los detalles del contenido.
      //final ContentDetails contentDetails = await extractContentDetailsFromMovie(id);
      // Realiza cualquier procesamiento adicional si es necesario.

      //return contentDetails;
    } catch (error) {
      // Manejar errores aquí
      return ContentDetails(
        genre: 'No se consiguio extraer la informacion',
        synopsisOrArtist: 'No se consiguio extraer la informacion',
        platforms: ['No se consiguio extraer la informacion'],
        imageUrl: '',
      );
    }*/
    return ContentDetails(
        genre: content!.genres.map((genreId) {
          return genreIdToNameMap[genreId] ?? 'Desconocido';
        }).toList().join(', '),
        synopsisOrArtist: content.sinopsis,
        platforms: ['Netflix'],
        imageUrl: 'https://firebasestorage.googleapis.com/v0/b/moodmatch-57ae2.appspot.com/o/defaultImages%2FdefaultMovie.png?alt=media&token=09516e2f-7862-4ade-a9f8-3c7339d56f49&_gl=1*487rno*_ga*NTI4NDgxMjk2LjE2OTU1MDI3MjU.*_ga_CW55HF8NVT*MTY5ODAzMzc4NS4xOS4xLjE2OTgwMzQxNzQuMzQuMC4w',
      );
  }


  
}



class LikeDislikeWidget extends StatefulWidget {
  final Details details;

  LikeDislikeWidget({required this.details});

  @override
  _LikeDislikeWidgetState createState() => _LikeDislikeWidgetState();
}

class _LikeDislikeWidgetState extends State<LikeDislikeWidget> {
  bool isLiked = false;
  bool isDisliked = false;

  void _addPreference(String type, bool liked) {
    final preferencesCollection = FirebaseFirestore.instance.collection('preferences');
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final preferencesDocument = preferencesCollection.doc(userUid);

    preferencesDocument.set(
      {
        'likes_dislikes.${widget.details.id}': {
          'type': type,
          'liked': liked,
        },
      },
      SetOptions(merge: true), // Esto fusionará los datos o creará el documento si no existe.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.thumb_up,
            color: isLiked ? MyApp.customSwatch : Colors.grey, // Cambia el color cuando es seleccionado
          ),
          onPressed: () {
            setState(() {
              isLiked = true; // Marca como seleccionado
              isDisliked = false; // Desmarca el botón "no gustar"
              _addPreference('pelicula', true);
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.thumb_down,
            color: isDisliked ? MyApp.customSwatch : Colors.grey, // Cambia el color cuando es seleccionado
          ),
          onPressed: () {
            setState(() {
              isDisliked = true; // Marca como seleccionado
              isLiked = false; // Desmarca el botón "gustar"
              _addPreference('pelicula', false);
            });
          },
        ),
      ],
    );
  }
}

