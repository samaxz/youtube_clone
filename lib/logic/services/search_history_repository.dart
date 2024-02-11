// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:sembast/sembast.dart';
import 'package:youtube_clone/logic/services/sembast_database.dart';

class SearchHistoryRepository {
  final SembastDatabase _sembastDatabase;

  SearchHistoryRepository(this._sembastDatabase);

  final _store = StoreRef<int, String>('search_history');

  static const historyLength = 10;

  Stream<List<String>> watchSearchTerms({String? filter}) {
    return _store
        .query(
          finder: filter != null && filter.isNotEmpty
              ? Finder(
                  filter: Filter.custom(
                    (record) => (record.value as String).startsWith(filter),
                  ),
                )
              : null,
        )
        .onSnapshots(_sembastDatabase.instance)
        .map(
          (records) => records.reversed.map((snapshot) => snapshot.value).toList(),
        );
  }

  Future<void> addSearchTerm(String term) async {
    await _addSearchTerm(
      term,
      _sembastDatabase.instance,
    );
  }

  Future<void> deleteSearchTerm(String term) async {
    await _deleteSearchTerm(
      term,
      _sembastDatabase.instance,
    );
  }

  Future<void> putSearchTermFirst(String term) async {
    await _sembastDatabase.instance.transaction(
      (transaction) async {
        await _deleteSearchTerm(
          term,
          transaction,
        );
        await _addSearchTerm(
          term,
          transaction,
        );
      },
    );
  }

  Future<void> _addSearchTerm(
    String term,
    DatabaseClient dbclient,
  ) async {
    final existingKey = await _store.findKey(
      dbclient,
      finder: Finder(
        filter: Filter.custom(
          (record) => record.value == term,
        ),
      ),
    );

    if (existingKey != null) {
      await putSearchTermFirst(term);

      return;
    }

    await _store.add(dbclient, term);

    final count = await _store.count(dbclient);

    if (count > historyLength) {
      await _store.delete(
        dbclient,
        finder: Finder(
          limit: count - historyLength,
        ),
      );
    }
  }

  Future<void> _deleteSearchTerm(
    String term,
    DatabaseClient dbclient,
  ) async {
    await _store.delete(
      dbclient,
      finder: Finder(
        filter: Filter.custom(
          (record) => record.value == term,
        ),
      ),
    );
  }
}
