import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'CLIENT_ID', obfuscate: true)
  static final String clientId = _Env.clientId;

  @EnviedField(varName: 'CLIENT_SECRET', obfuscate: true)
  static final String clientSecret = _Env.clientSecret;

  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final String apiKey = _Env.apiKey;
}
