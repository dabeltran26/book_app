import 'dart:convert';

import 'package:books_app/utils/constants.dart';

DocumentModel postModelFromJson(String str) =>
    DocumentModel.fromJson(json.decode(str));

String documentModelToJson(DocumentModel data) => json.encode(data.toJson());

class DocumentModel {
  String titleSuggest;
  List<String> editionKey;
  int coverId;
  List<String> isbn;
  bool hasFulltext;
  List<String> authorName;
  List<String> contributor;
  List<String> authorKey;
  int firstPublishYear;
  String title;
  List<String> publisher;
  List<String> language;
  DocumentModel({
    required this.titleSuggest,
    required this.editionKey,
    required this.coverId,
    required this.isbn,
    required this.hasFulltext,
    required this.authorName,
    required this.contributor,
    required this.authorKey,
    required this.firstPublishYear,
    required this.title,
    required this.publisher,
    required this.language,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        titleSuggest: json['title_suggest'] != null ? json['title_suggest'] as String : '',
        editionKey: json['edition_key'] != null ? json['edition_key'].map<String>((document) {
          return document.toString();
        }).toList():[''],
        coverId: json['cover_i'] != null ? json['cover_i'] as int : 0,
        isbn: json['isbn'] != null ? json['isbn'].map<String>((document) {
          return document.toString();
        }).toList() : [''],
        hasFulltext: json['has_fulltext'] != null ? json['has_fulltext'] as bool: false,
        authorName: json['author_name'] != null ? json['author_name'].map<String>((document) {
          return document.toString();
        }).toList(): [''],
        contributor: json['contributor'] != null ?json['contributor'].map<String>((document) {
          return document.toString();
        }).toList() : [''],
        authorKey: json['author_key'] != null ? json['author_key'].map<String>((document) {
          return document.toString();
        }).toList(): [''],
        firstPublishYear: json['first_publish_year'] != null ? json['first_publish_year'] as int : 0,
        title: json['title'] != null ? json['title'] as String : '',
        publisher: json['publisher'] != null ? json['publisher'].map<String>((document) {
          return document.toString();
        }).toList():[''],
        language: json['language'] != null ? json['language'].map<String>((document) {
          return document.toString();
        }).toList():[''],
      );

  Map<String, dynamic> toJson() => {
        'title_suggest': titleSuggest,
        'edition_key': editionKey,
        'cover_i': coverId,
        'isbn': isbn,
        'has_fulltext': hasFulltext,
        'author_name': authorName,
        'contributor': contributor,
        'author_key': authorKey,
        'first_publish_year': firstPublishYear,
        'title': title,
        'publisher': publisher,
        'language': language
      };

  String getBookCover() {
    return "${Constants.baseUrlCover}b/id/$coverId.jpg";
  }
}
