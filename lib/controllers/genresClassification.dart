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

  return genreIds.join('|'); // Une los IDs con pipe para que sea uno u otro
}

final genreIdToNameMap = {
  28: "Action",
  12: "Adventure",
  16: "Animation",
  35: "Comedy",
  80: "Crime",
  99: "Documentary",
  18: "Drama",
  10751: "Family",
  14: "Fantasy",
  36: "History",
  27: "Horror",
  10402: "Music",
  9648: "Mystery",
  10749: "Romance",
  878: "Science Fiction",
  10770: "TV Movie",
  53: "Thriller",
  10752: "War",
  37: "Western",
};

final genreMusicNameMap = {
  1: 'acoustic',
  2: 'alternative',
  3: 'ambient',
  4: 'anime',
  5: 'black-metal',
  6: 'blues',
  7: 'bossanova',
  8: 'children',
  9: 'chill',
  10: 'classical',
  11: 'disco',
  12: 'dubstep',
  13: 'electro',
  14: 'funk',
  15: 'hard-rock',
  16: 'heavy-metal',
  17: 'hip-hop',
  18: 'house',
  19: 'idm',
  20: 'j-pop',
  21: 'j-rock',
  22: 'jazz',
  23: 'k-pop',
  24: 'latino',
  25: 'metal',
  26: 'party',
  27: 'piano',
  28: 'pop',
  29: 'punk',
  30: 'reggae',
  31: 'reggaeton',
  32: 'rock',
  33: 'rock-n-roll',
  34: 'romance',
  35: 'salsa',
  36: 'samba',
  37: 'sleep',
  38: 'soul',
  39: 'soundtracks',
  40: 'study',
  41: 'tango',
  42: 'techno',
};

final invertedGenreMusicMap = {
  'acoustic': 1,
  'alternative': 2,
  'ambient': 3,
  'anime': 4,
  'black-metal': 5,
  'blues': 6,
  'bossanova': 7,
  'children': 8,
  'chill': 9,
  'classical': 10,
  'disco': 11,
  'dubstep': 12,
  'electro': 13,
  'funk': 14,
  'hard-rock': 15,
  'heavy-metal': 16,
  'hip-hop': 17,
  'house': 18,
  'idm': 19,
  'j-pop': 20,
  'j-rock': 21,
  'jazz': 22,
  'k-pop': 23,
  'latino': 24,
  'metal': 25,
  'party': 26,
  'piano': 27,
  'pop': 28,
  'punk': 29,
  'reggae': 30,
  'reggaeton': 31,
  'rock': 32,
  'rock-n-roll': 33,
  'romance': 34,
  'salsa': 35,
  'samba': 36,
  'sleep': 37,
  'soul': 38,
  'soundtracks': 39,
  'study': 40,
  'tango': 41,
  'techno': 42,
};