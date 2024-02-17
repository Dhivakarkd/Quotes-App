import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/model/Quote.dart';
import 'package:quotes/widgets/quotesApp.dart';
import 'package:english_words/english_words.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<QuoteState>();
    var quote = appState.current;

    IconData icon;
    if (appState.favorites.contains(quote)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          BigCard(quote: quote),
          SizedBox(height: 10),
          Expanded(
            flex: 2, // Adjust the flex factor as needed
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        appState.toggleFavorite();
                      },
                      icon: Icon(icon),
                      label: Text('Like'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        appState.getNext();
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.quote,
  }) : super(key: key);

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: Duration(milliseconds: 200),
          // Make sure that the compound word wraps correctly when the window
          // is too narrow.
          child: MergeSemantics(
            child: Wrap(
              children: [
                Text(
                  quote.firstLine,
                  style: style.copyWith(fontWeight: FontWeight.w200),
                ),
                Text(
                  quote.secondLine,
                  style: style.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
