import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/Quote.dart';

class QuoteProvider {
  Future<List<Quote>> fetchQuotes() async {
    final response = await http
        .get(Uri.parse('https://api.quotable.io/quotes/random?maxLength=90'));

    if (response.statusCode == 200) {
      final List<dynamic> quoteJsonList = jsonDecode(response.body);
      return quoteJsonList.map((json) => Quote.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}
