List<dynamic> genres =  [
      {
        "id": 28,
        "name": "Action",
        "emotion": "joy"
      },
      {
        "id": 12,
        "name": "Adventure",
        "emotion": "joy"
      },
      {
        "id": 16,
        "name": "Animation",
        "emotion": "joy"
      },
      {
        "id": 35,
        "name": "Comedy",
        "emotion": "joy"
      },
      {
        "id": 80,
        "name": "Crime",
        "emotion": "anger"
      },
      {
        "id": 99,
        "name": "Documentary",
        "emotion": "surprise"
      },
      {
        "id": 18,
        "name": "Drama",
        "emotion": "sadness"
      },
      {
        "id": 10751,
        "name": "Family",
        "emotion": "joy"
      },
      {
        "id": 14,
        "name": "Fantasy",
        "emotion": "joy"
      },
      {
        "id": 36,
        "name": "History",
        "emotion": "sadness"
      },
      {
        "id": 27,
        "name": "Horror",
        "emotion": "fear"
      },
      {
        "id": 10402,
        "name": "Music",
        "emotion": "joy"
      },
      {
        "id": 9648,
        "name": "Mystery",
        "emotion": "surprise"
      },
      {
        "id": 10749,
        "name": "Romance",
        "emotion": "joy"
      },
      {
        "id": 878,
        "name": "Science Fiction",
        "emotion": "surprise"
      },
      {
        "id": 10770,
        "name": "TV Movie",
        "emotion": "joy"
      },
      {
        "id": 53,
        "name": "Thriller",
        "emotion": "fear"
      },
      {
        "id": 10752,
        "name": "War",
        "emotion": "anger"
      },
      {
        "id": 37,
        "name": "Western",
        "emotion": "joy"
      }
    ];

dynamic class_genres = {
"joy" : [
  {
    "id": 28,
    "name": "Action",
    "emotion": "joy"
  },
  {
    "id": 12,
    "name": "Adventure",
    "emotion": "joy"
  },
  {
    "id": 16,
    "name": "Animation",
    "emotion": "joy"
  },
  {
    "id": 35,
    "name": "Comedy",
    "emotion": "joy"
  },
  {
    "id": 10751,
    "name": "Family",
    "emotion": "joy"
  },
  {
    "id": 14,
    "name": "Fantasy",
    "emotion": "joy"
  },
  {
    "id": 10402,
    "name": "Music",
    "emotion": "joy"
  },
  {
    "id": 10749,
    "name": "Romance",
    "emotion": "joy"
  },
  {
    "id": 10770,
    "name": "TV Movie",
    "emotion": "joy"
  },
  {
    "id": 37,
    "name": "Western",
    "emotion": "joy"
  }
],
"anger" : [
  {
    "id": 80,
    "name": "Crime",
    "emotion": "anger"
  },
  {
    "id": 10752,
    "name": "War",
    "emotion": "anger"
  }
],
"surprise" : [
  {
    "id": 99,
    "name": "Documentary",
    "emotion": "surprise"
  },
  {
    "id": 9648,
    "name": "Mystery",
    "emotion": "surprise"
  },
  {
    "id": 878,
    "name": "Science Fiction",
    "emotion": "surprise"
  },
],
"sadness" : [
  {
    "id": 18,
    "name": "Drama",
    "emotion": "sadness"
  },
  {
    "id": 36,
    "name": "History",
    "emotion": "sadness"
  }
],
"fear" : [
  {
    "id": 27,
    "name": "Horror",
    "emotion": "fear"
  },
  {
    "id": 53,
    "name": "Thriller",
    "emotion": "fear"
  }
]
};


String getGenreIdsAsString(String emotion) {
  List<dynamic> genres = class_genres[emotion];
  List<int> genreIds = [];

  for (var genre in genres) {
    if (genre['emotion'] == emotion) {
      genreIds.add(genre['id']);
    }
  }

  return genreIds.join(','); // Une los IDs con espacios
}