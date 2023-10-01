import 'package:flutter/material.dart';
import 'package:mood_match/widgets/Custom_Loader.dart';
import 'package:mood_match/widgets/custom_app_bar.dart';

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
  final String? type;
  final String? title;

  Details({this.type, this.title});

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
