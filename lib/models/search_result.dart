import 'dart:convert';
import 'package:books_app/models/document.dart';

SearchResult postModelFromJson(String str) =>
    SearchResult.fromJson(json.decode(str));

String postModelToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
  int start;
  int numFound;
  List<DocumentModel> docs;

  SearchResult({
    required this.start,
    required this.numFound,
    required this.docs,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        start: json['start'] as int,
        numFound: json['numFound'] as int,
        docs: json['docs'].map<DocumentModel>(
            (document){
              return  DocumentModel.fromJson(document);
            }
        ).toList(),
      );

  Map<String, dynamic> toJson() =>
      {'start': start, 'numFound': numFound, 'docs': docs};
}