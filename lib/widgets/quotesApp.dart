import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/service/QuoteProvider.dart';
import 'package:quotes/widgets/homePage.dart';

import '../model/Quote.dart';

class QuotesApp extends StatelessWidget {
  const QuotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuoteState(),
      child: MaterialApp(
        title: 'Quotes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: const HomePage(),
      ),
    );
  }
}

class QuoteState extends ChangeNotifier {
  final QuoteProvider _quoteProvider = QuoteProvider();
  List<Quote> quotes = [];
  late Quote current = _getDefaultQuote();
  var favorites = <Quote>[];

  QuoteState() {
    getNext();
  }

  Future<void> getNext() async {
    try {
      // Fetch quotes from the API
      current = await _fetchNextQuote();
    } catch (e) {
      print('Error fetching quotes: $e');
      current = _getDefaultQuote();
    }
    notifyListeners();
  }

  Future<Quote> _fetchNextQuote() async {
    quotes = await _quoteProvider.fetchQuotes();
    return quotes.isNotEmpty ? quotes[0] : _getDefaultQuote();
  }

  Quote _getDefaultQuote() {
    return Quote(
      id: '',
      content: 'Default quote content',
      author: 'Default author',
      tags: [],
      authorSlug: '',
      length: 0,
      dateAdded: '',
      dateModified: '',
    );
  }

  void toggleFavorite([Quote? quote]) {
    quote = quote ?? current;
    if (quote != null) {
      if (favorites.contains(quote)) {
        favorites.remove(quote);
      } else {
        favorites.add(quote);
      }
      notifyListeners();
    }
  }

  void removeFavorite(Quote quote) {
    favorites.remove(quote);
    notifyListeners();
  }
}
