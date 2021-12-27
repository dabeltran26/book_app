import 'dart:convert';
import 'package:books_app/models/document.dart';
import 'package:books_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class FavoriteBookRepository {
  String baseUrl = Constants.baseUrlFirebaseDb;
  final FirebaseAuth _firebaseAuth;

  FavoriteBookRepository({FirebaseAuth? firebaseAuth}) :_firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;


  Future<bool> saveBook(DocumentModel book) async {
    final url = Uri.parse("$baseUrl/favorite_book/${_firebaseAuth.currentUser?.uid}.json");
    final resp = await http.post(url, body: documentModelToJson(book));
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteBook(DocumentModel book) async {
    bool response = false;
    final urlGet = Uri.parse("$baseUrl/favorite_book/${_firebaseAuth.currentUser?.uid}.json");
    final resp = await http.get(urlGet);
    if (json.decode(resp.body) != null) {
      final Map<String, dynamic> decodedData = json.decode(resp.body);
       decodedData.forEach((key, value) async {
        if(value['title'] == book.title){
          final urlDelete = Uri.parse("$baseUrl/favorite_book/${_firebaseAuth.currentUser?.uid}/${key}.json");
          final resp = await http.delete(urlDelete);
          if (resp.statusCode == 200) {
            response =  true;
          } else {
            response = false;
          }
        }
      });
    }
    return response;
  }

  Future<List<DocumentModel>> getFavoritesBooks() async {
    final url = Uri.parse("$baseUrl/favorite_book/${_firebaseAuth.currentUser?.uid}.json");
    final resp = await http.get(url);
    if (json.decode(resp.body) != null) {
      final Map<String, dynamic> decodedData = json.decode(resp.body);
      final List<DocumentModel> books = [];
      decodedData.forEach((id, book) {
        final bookTemp = DocumentModel.fromJson(book);
        books.add(bookTemp);
      });
      return books;
    }else{
      return [];
    }
  }

}
