import 'dart:convert';
import 'package:books_app/models/search_result.dart';
import 'package:books_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class HomeRepository{

  final String baseUrl;

  HomeRepository({
    this.baseUrl = Constants.baseUrl
  });

  Future<SearchResult> fetchSearchResults(String name) async {
    final uri = Uri.parse("${baseUrl}search.json?q=$name");
    final response = await http.get(uri);
    return SearchResult.fromJson(json.decode(response.body));
  }
}