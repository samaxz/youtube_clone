import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:oauth2/oauth2.dart';

class SecureCredentialsStorage {
  final FlutterSecureStorage _storage;

  final String _key = 'oauth2_credentials';

  Credentials? _cachedCredentials;

  SecureCredentialsStorage(this._storage);

  // it's used to read the credentials to get the access token
  Future<Credentials?> read() async {
    if (_cachedCredentials != null) {
      return _cachedCredentials;
    }
    // if the credentials aren't cached yet, i've gotta read the storage
    final json = await _storage.read(key: _key);
    if (json == null) {
      return null;
    }
    try {
      // getting credentials from the storage
      final cachedCredentials = Credentials.fromJson(json);
      return cachedCredentials;
    } on FormatException {
      // user isn't authenticated
      return null;
    }
  }

  // this method will only run when the user signs in
  Future<void> save(Credentials credentials) async {
    // writing to the cached credentials whenever the save() method runs
    _cachedCredentials = credentials;
    return await _storage.write(
      key: _key,
      // json representation of the credentials
      value: credentials.toJson(),
    );
  }

  Future<void> clear() async {
    _cachedCredentials = null;
    return await _storage.delete(key: _key);
  }
}
