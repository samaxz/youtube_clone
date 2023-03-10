// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xml/xml.dart';

import 'package:youtube_demo/services/common/providers.dart';
import 'package:youtube_demo/services/notifiers/searched_items_notifier.dart';
import 'package:youtube_demo/widgets/searched_videos_list.dart';

// * fetching suggestions
final suggestionsProvider =
    FutureProvider.autoDispose.family<List<String>, String>((ref, query) async {
  final dio = ref.read(authDioP);

  final response = await dio.getUri(
    Uri.parse('https://google.com/complete/search?output=xml&hl=en&q=$query'),
  );

  final data = response.data.toString();
  final document = XmlDocument.parse(data);
  final suggestionElements = document.findAllElements('suggestion').toList();

  final suggestions = suggestionElements
      .map((element) => element.getAttribute('data')!)
      .toList();

  return suggestions;
});

class CustomSearchDelegate extends SearchDelegate {
  final WidgetRef _ref;
  final int _index;

  CustomSearchDelegate(this._ref, this._index);

  @override
  void close(BuildContext context, result) {
    super.close(context, result);
    _ref.read(showSearchSP.notifier).update((state) => true);
    _ref.read(pushedHomeChannelSP.notifier).update((state) => false);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.trim().isEmpty) {
            _ref.read(searchHistorySNP.notifier).deleteSearchTerm(query);
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.microtask(
      () => _ref.read(showSearchSP.notifier).update((state) => true),
    );

    if (query.trim().isEmpty) {
      return const SizedBox.shrink();
    } else {
      final newQuery = query.trim();
      _ref.read(searchHistorySNP.notifier).addSearchTerm(newQuery);

      return SearchedVideosList(
        query: query,
        index: _index,
      );
    }
  }

  // * this widget is responsible for displaying all the suggestions
  @override
  Widget buildSuggestions(BuildContext context) {
    Future.microtask(
      () => _ref.read(showSearchSP.notifier).update((state) => false),
    );

    return Material(
      color: Theme.of(context).cardColor,
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: Consumer(
        builder: (context, ref, child) {
          ref.watch(searchHistorySNP.notifier).watchSearchTerms(filter: query);

          final searchHistoryState = ref.watch(searchHistorySNP);

          final searchNotifier = ref.read(searchItemsNotifierProvider.notifier);

          // * this is a more of an elegant approach, which doesn't use
          // * nested whens, but does use one nested consumer, however
          return ListView(
            children: [
              searchHistoryState.when(
                data: (data) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      query = data[index];
                      showResults(context);
                    },
                    title: Text(data[index]),
                    leading: IconButton(
                      // when user presses this button, the query will be filled
                      // inside the search bar and the results for that query
                      // will be shown
                      onPressed: () {
                        query = data[index];
                        searchNotifier.searchItems(query: query, index: _index);
                        showResults(context);
                      },
                      icon: const Icon(Icons.history),
                    ),
                    trailing: IconButton(
                      onPressed: () => ref
                          .read(searchHistorySNP.notifier)
                          .deleteSearchTerm(data[index]),
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
                // TODO prolly fix this
                error: (error, stackTrace) => const Center(
                  child: Text('error happened'),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              if (query.isNotEmpty) ...[
                Consumer(
                  builder: (context, ref, _) {
                    final asyncSuggestions = ref.watch(
                      suggestionsProvider(query),
                    );

                    return asyncSuggestions.when(
                      data: (data) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            ref
                                .read(searchHistorySNP.notifier)
                                .addSearchTerm(data[index]);
                            query = data[index];
                            showResults(context);
                          },
                          title: Text(data[index]),
                          leading: IconButton(
                            onPressed: () {
                              ref
                                  .read(searchHistorySNP.notifier)
                                  .addSearchTerm(data[index]);
                              query = data[index];
                              showResults(context);
                            },
                            icon: const Icon(Icons.search),
                          ),
                          // * putting the search term inside search bar
                          trailing: IconButton(
                            onPressed: () => query = data[index],
                            icon: const Icon(Icons.arrow_outward),
                          ),
                        ),
                      ),
                      // TODO prolly fix this
                      error: (error, stackTrace) => const Center(
                        child: Text('error happened'),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
