import 'package:books_app/models/document.dart';
import 'package:books_app/repository/favorite_book_repository.dart';
import 'package:books_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'favorite_test.mocks.dart';

class Client extends Mock implements http.Client {}

@GenerateMocks([Client])
main() async {
  FavoriteBookRepository favoriteRepository = FavoriteBookRepository();
  String baseUrl = Constants.baseUrlFirebaseDb;
  var firebaseAuth = FirebaseAuth.instance;

  setUpAll(() async {
    await Firebase.initializeApp();
    firebaseAuth.signInWithEmailAndPassword(email: 'david.beltran2326@gmail.com', password: 'qwerty123');
  });

  test('returns a favorites books', () async {
    var client = MockClient();
    final url = Uri.parse("$baseUrl/favorite_book/${firebaseAuth.currentUser?.uid}.json");
    when(client.get(url))
        .thenAnswer((_) async => http.Response('', 200));

    expect(await favoriteRepository.getFavoritesBooks(), isA<List<DocumentModel>>());
  });
}
