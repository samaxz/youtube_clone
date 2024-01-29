// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _Env {
  static const List<int> _enviedkeyclientId = <int>[];

  static const List<int> _envieddataclientId = <int>[];

  static final String clientId = String.fromCharCodes(List<int>.generate(
    _envieddataclientId.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddataclientId[i] ^ _enviedkeyclientId[i]));

  static const List<int> _enviedkeyclientSecret = <int>[];

  static const List<int> _envieddataclientSecret = <int>[];

  static final String clientSecret = String.fromCharCodes(List<int>.generate(
    _envieddataclientSecret.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddataclientSecret[i] ^ _enviedkeyclientSecret[i]));

  static const List<int> _enviedkeyapiKey = <int>[];

  static const List<int> _envieddataapiKey = <int>[];

  static final String apiKey = String.fromCharCodes(List<int>.generate(
    _envieddataapiKey.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]));
}
