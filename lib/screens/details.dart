import 'package:flutter/material.dart';
import 'package:mood_match/widgets/Custom_Loader.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContentDetails {
  final String genre;
  final String? synopsisOrArtist;
  final List<String> platforms;
  final String imageUrl;

  ContentDetails({
    required this.genre,
    this.synopsisOrArtist,
    required this.platforms,
    required this.imageUrl,
  });
}

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
    fetchContentDetails(widget.type, widget.title).then((details) {
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

  Widget _buildImageCard(String imageUrl) {
    return Container(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: imageUrl.isNotEmpty
            ? Image.network(
          imageUrl,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Image.asset('assets/images/defaultMovie.png'); 
          },
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,

        )
            : Image.asset(
          'assets/images/defaultMovie.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
        ),
      ),
    );
  }

  Future<ContentDetails> fetchContentDetails(String? type, String? title) async {
    // Tu lógica para obtener los detalles del contenido desde el backend
    // ...
    // Ejemplo simulado con datos estáticos
    await Future.delayed(Duration(seconds: 2));
    return ContentDetails(
      genre: 'Fantasía',
      synopsisOrArtist: 'Una emocionante historia de aventuras.',
      platforms: ['Netflix', 'Amazon Prime', 'Hulu'],
      imageUrl: ' ',
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
  void _addPreference(String type, bool liked) {
    FirebaseFirestore.instance.collection('preferences').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'likes_dislikes.${widget.details.id}': {
        'type': type,
        'liked': liked,
      },
    });
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

