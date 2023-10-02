import 'package:flutter/material.dart';
import 'package:mood_match/widgets/Custom_Loader.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:mood_match/models/contentDetails.dart';
import 'package:mood_match/controllers/recommendations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  final num id;
  final String? type;
  final String? title;

  Details({required this.id,this.type, this.title});

  @override
  _DetailsContent createState() => _DetailsContent();
}

class _DetailsContent extends State<Details> {
  ContentDetails? contentDetails;

  @override
  void initState() {
    super.initState();
    fetchContentDetails(widget.id,widget.type, widget.title).then((details) {
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


  Future<ContentDetails> fetchContentDetails(num id, String? type, String? title) async {

    try {
    // Llama a extractContentDetailsFromMovie para obtener los detalles del contenido.
    final ContentDetails contentDetails = await extractContentDetailsFromMovie(id);
    // Realiza cualquier procesamiento adicional si es necesario.

    return contentDetails;
  } catch (error) {
    // Manejar errores aquí
    return ContentDetails(
      genre: 'No se consiguio extraer la informacion',
      synopsisOrArtist: 'No se consiguio extraer la informacion',
      platforms: ['No se consiguio extraer la informacion'],
      imageUrl: '',
    );
  }
  }


  
}



class LikeDislikeWidget extends StatefulWidget {
  final Details details;

  LikeDislikeWidget({required this.details});

  @override
  _LikeDislikeWidgetState createState() => _LikeDislikeWidgetState();
}

class _LikeDislikeWidgetState extends State<LikeDislikeWidget> {
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
          icon: Icon(Icons.thumb_up),
          onPressed: () {
            _addPreference('pelicula', true);
          },
        ),
        IconButton(
          icon: Icon(Icons.thumb_down),
          onPressed: () {
            _addPreference('pelicula', false);
          },
        ),
      ],
    );
  }
}
