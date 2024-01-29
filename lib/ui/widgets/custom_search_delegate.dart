// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xml/xml.dart';
import 'package:youtube_clone/logic/notifiers/searched_items_notifier.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/ui/widgets/searched_videos_list.dart';

// fetching search suggestions
final suggestionsFP = FutureProvider.autoDispose.family<List<String>, String>((ref, query) async {
  final dio = ref.read(dioP);
  final response = await dio.getUri(
    Uri.parse('https://google.com/complete/search?output=xml&hl=en&q=$query'),
  );
  final data = response.data.toString();
  final document = XmlDocument.parse(data);
  final suggestionElements = document.findAllElements('suggestion').toList();
  final suggestions = suggestionElements.map((element) => element.getAttribute('data')!).toList();

  return suggestions;
});

class CustomSearchDelegate extends SearchDelegate {
  final WidgetRef ref;
  final int screenIndex;

  CustomSearchDelegate({
    required this.ref,
    required this.screenIndex,
  });

  // my guess is that this is the problem
  // with this, i can (probably) remove indexes form the search SP
  // late int screenIndex = ref.read(currentScreenIndexSP);

  @override
  void close(BuildContext context, result) {
    super.close(context, result);

    ref.read(isShowingSearchSP(screenIndex).notifier).update((state) => false);
    // _ref.read(isShowingSearchSP.notifier).update((state) => false);
    // TODO update other providers here
    // _ref.read(pushedHomeChannelSP.notifier).update((state) => false);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.trim().isEmpty) {
            ref.read(searchHistorySNP.notifier).deleteSearchTerm(query);
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
      () => ref.read(isShowingSearchSP(screenIndex).notifier).update((state) => false),
      // () => _ref.read(isShowingSearchSP.notifier).update((state) => false),
    );

    if (query.trim().isEmpty) {
      return const SizedBox.shrink();
    } else {
      final newQuery = query.trim();
      ref.read(searchHistorySNP.notifier).addSearchTerm(newQuery);

      return SearchedVideosList(
        query: query,
        index: screenIndex,
      );
    }
  }

  // this widget is responsible for displaying all the searching suggestions
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO remove this
    // Future.microtask(
    //   () => _ref.read(isShowingSearchSP(screenIndex).notifier).update((state) => false),
    // );

    return Material(
      color: Theme.of(context).cardColor,
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: Consumer(
        builder: (context, ref, child) {
          ref.watch(searchHistorySNP.notifier).watchSearchTerms(filter: query);

          final searchHistoryState = ref.watch(searchHistorySNP);
          final searchNotifier = ref.read(searchItemsNotifierProvider.notifier);

          // this is a more of an elegant approach, which doesn't use
          // nested whens, but does use one nested consumer, however
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
                        searchNotifier.searchItems(query: query, index: screenIndex);
                        showResults(context);
                      },
                      icon: const Icon(Icons.history),
                    ),
                    trailing: IconButton(
                      onPressed: () =>
                          ref.read(searchHistorySNP.notifier).deleteSearchTerm(data[index]),
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
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
                      suggestionsFP(query),
                    );

                    return asyncSuggestions.when(
                      data: (data) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            ref.read(searchHistorySNP.notifier).addSearchTerm(data[index]);
                            query = data[index];
                            showResults(context);
                          },
                          title: Text(data[index]),
                          leading: IconButton(
                            onPressed: () {
                              ref.read(searchHistorySNP.notifier).addSearchTerm(data[index]);
                              query = data[index];
                              showResults(context);
                            },
                            icon: const Icon(Icons.search),
                          ),
                          // putting the search term inside search bar
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
