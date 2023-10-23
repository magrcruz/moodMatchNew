#test
import csv
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

base_url = "D:\\Repositorios\\MoodMatchNewCopy\\mood_match\\uploadMovies\\"

# Inicializa Firebase con la credencial de servicio
cred = credentials.Certificate(base_url + "moodmatch-57ae2-firebase-adminsdk-tsqlj-d55ccb4b52.json")
firebase_admin.initialize_app(cred)

# Inicializa Firestore
db = firestore.client()

# Ruta de la colección en Firestore
coleccion_ref = db.collection('Movies')

# Ruta del archivo CSV
archivo_csv = base_url + 'movieEmotion.csv'

k = 0

# Abre el archivo CSV y sube los datos a Firestore
with open(archivo_csv, mode='r') as csv_file:
    csv_reader = csv.DictReader(csv_file)
    for row in csv_reader:
        # Convierte las cadenas entre corchetes a listas (usando eval)
        row['genres'] = eval(row['genres'])

        # Utiliza el valor de 'tconst' como clave del documento
        tconst = row['tconst']

        # Elimina 'tconst' del diccionario para evitar duplicación
        del row['tconst']

        # Agrega los datos a Firestore con 'tconst' como clave del documento
        coleccion_ref.document(tconst).set(row)


print("Subida de datos completada")
