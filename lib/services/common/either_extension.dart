import 'package:dartz/dartz.dart';

extension EitherExtension<L, R> on Either<L, R> {
  L? get leftOrDefault => fold((l) => l, (_) => null);
  R? get rightOrDefault => fold((_) => null, (r) => r);
}
