import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/logic/services/search_history_repository.dart';

class SearchHistoryNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final SearchHistoryRepository _repository;

  SearchHistoryNotifier(this._repository) : super(const AsyncLoading());

  // this could probably be inside constructor's body
  void watchSearchTerms({String? filter}) {
    _repository.watchSearchTerms(filter: filter).listen(
      (data) {
        state = AsyncData(data);
      },
      onError: (
        Object error,
        StackTrace stackTrace,
      ) {
        state = AsyncError(
          error,
          stackTrace,
        );
      },
    );
  }

  Future<void> addSearchTerm(String term) async {
    await _repository.addSearchTerm(term);
  }

  Future<void> deleteSearchTerm(String term) async {
    await _repository.deleteSearchTerm(term);
  }

  Future<void> putSearchTermFirst(String term) async {
    await _repository.putSearchTermFirst(term);
  }
}
