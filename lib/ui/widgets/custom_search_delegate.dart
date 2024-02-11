// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xml/xml.dart';
import 'package:youtube_clone/data/custom_screen.dart';
import 'package:youtube_clone/logic/notifiers/providers.dart';
import 'package:youtube_clone/logic/notifiers/screens_manager.dart';
import 'package:youtube_clone/logic/notifiers/searched_items_notifier.dart';
import 'package:youtube_clone/ui/widgets/searched_items_list.dart';

// fetching search suggestions
final suggestionsFP = FutureProvider.autoDispose.family((ref, String query) async {
  final dio = ref.read(dioP);
  final response = await dio.getUri(
    Uri.parse('https://google.com/complete/search?output=xml&hl=en&q=$query'),
  );
  final data = response.data.toString();
  final document = XmlDocument.parse(data);
  final suggestionElements = document.findAllElements('suggestion').toList();
  final suggestions = suggestionElements
      .map(
        (element) => element.getAttribute('data')!,
      )
      .toList();

  return suggestions;
});

class CustomSearchDelegate extends SearchDelegate {
  final WidgetRef ref;
  final int screenIndex;

  CustomSearchDelegate({
    required this.ref,
    required this.screenIndex,
  });

  @override
  void close(BuildContext context, result) {
    super.close(context, result);
    showSuggestions(context);

    ref.read(isShowingSearchSP(screenIndex).notifier).update((state) => false);
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
            showSuggestions(context);
            ref.read(screensManagerProvider(screenIndex).notifier).popScreen();
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
      icon: const Icon(Icons.chevron_left, size: 31),
    );
  }

  @override
  void showResults(BuildContext context) {
    super.showResults(context);

    // could use read
    final screensManager = ref.watch(screensManagerProvider(screenIndex));

    Future.microtask(
      () {
        ref.read(isShowingSearchSP(screenIndex).notifier).update((state) => false);

        // this fixes the pushing to searched list from channel screen problem
        if (screensManager.last.screenTypeAndId.screenType == ScreenType.channel) return;

        final notifier = ref.read(screensManagerProvider(screenIndex).notifier);
        notifier.pushScreen(
          CustomScreen.search(
            query: query,
            screenIndex: screenIndex,
          ),
          shouldPushNewScreen: false,
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return const Center(
        child: Text('write a term to start searching'),
      );
    } else {
      final newQuery = query.trim();
      ref.read(searchHistorySNP.notifier).addSearchTerm(newQuery);

      return SearchedItemsList(
        query: query,
        screenIndex: screenIndex,
      );
    }
  }

  Future<void> searchTerm(
    String term,
    BuildContext context, {
    bool isSuggestion = false,
  }) async {
    query = term;
    showResults(context);

    final itemsNotifier = ref.read(searchItemsNotifierProvider(screenIndex).notifier);
    await itemsNotifier.searchItems(query: query, screenIndex: screenIndex);

    final historyNotifier = ref.read(searchHistorySNP.notifier);

    if (isSuggestion) {
      await historyNotifier.addSearchTerm(query);
    } else {
      await historyNotifier.putSearchTermFirst(query);
    }
  }

  Future<void> removeTerm(String term) async {
    final notifier = ref.read(searchHistorySNP.notifier);
    notifier.deleteSearchTerm(term);
  }

  @override
  void showSuggestions(BuildContext context) {
    super.showSuggestions(context);
    ref.read(isShowingSearchSP(screenIndex).notifier).update((state) => true);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: Consumer(
        builder: (context, ref, _) {
          // not showing empty string
          ref.watch(searchHistorySNP.notifier).watchSearchTerms(filter: query.trim());

          final searchHistory = ref.watch(searchHistorySNP);

          return ListView(
            children: [
              searchHistory.when(
                data: (data) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => searchTerm(data[index], context),
                    title: Text(data[index]),
                    // i could just make it an icon
                    leading: IconButton(
                      // when user presses this button, the query will be filled
                      // inside the search bar and the results for that query
                      // will be shown
                      onPressed: () => searchTerm(data[index], context),
                      icon: const Icon(Icons.history),
                    ),
                    trailing: IconButton(
                      onPressed: () => removeTerm(data[index]),
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
              if (query.trim().isNotEmpty) ...[
                Consumer(
                  builder: (context, ref, _) {
                    final asyncSuggestions = ref.watch(
                      suggestionsFP(query),
                    );

                    return asyncSuggestions.when(
                      data: (data) {
                        // it won't be null, cause it's inside data state
                        // this is safe to use, because searchHistory will always be in data state
                        // (maybe except for a few very rare cases)
                        final history = searchHistory.value!;
                        data.removeWhere((element) => history.contains(element));

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) => ListTile(
                            onTap: () {
                              searchTerm(data[index], context, isSuggestion: true);
                            },
                            title: Text(data[index]),
                            leading: IconButton(
                              onPressed: () {
                                searchTerm(data[index], context, isSuggestion: true);
                              },
                              icon: const Icon(Icons.search),
                            ),
                            // putting the search term inside search bar
                            trailing: IconButton(
                              onPressed: () => query = data[index],
                              icon: const Icon(Icons.arrow_outward),
                            ),
                          ),
                        );
                      },
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
