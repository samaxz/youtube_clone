import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/logic/services/search_history_repository.dart';

class SearchHistoryNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final SearchHistoryRepository _repository;

  SearchHistoryNotifier(this._repository) : super(const AsyncValue.loading());

  void watchSearchTerms({String? filter}) {
    _repository.watchSearchTerms(filter: filter).listen(
      (data) {
        state = AsyncValue.data(data);
      },
      onError: (
        Object error,
        StackTrace stackTrace,
      ) {
        state = AsyncValue.error(
          error,
          stackTrace,
        );
      },
    );
  }

  Future<void> addSearchTerm(String term) async {
    return await _repository.addSearchTerm(term);
  }

  Future<void> deleteSearchTerm(String term) async {
    return await _repository.deleteSearchTerm(term);
  }

  Future<void> putSearchTermFirst(String term) async {
    return await _repository.putSearchTermFirst(term);
  }
}
