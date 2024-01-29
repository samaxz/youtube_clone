import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_interceptor.g.dart';

// TODO delete this
@riverpod
ServiceInterceptor serviceInterceptor(ServiceInterceptorRef ref) {
  return ServiceInterceptor();
}

class ServiceInterceptor extends Interceptor {
  @override
  onError(DioException err, ErrorInterceptorHandler handler) async {
    // switch (err.type) {
    //   // case DioExceptionType.connectTimeout:
    //   case DioExceptionType.sendTimeout:
    //   case DioExceptionType.receiveTimeout:
    //   case DioExceptionType.badResponse:
    //   // case DioExceptionType.response:
    //   case DioExceptionType.cancel:
    //   // case DioExceptionType.other:
    //   // err = YourCustomizeErrorDioException(
    //   //   //Your implement your Exeption implements of DioError, if you want
    //   //   'Your message',
    //   //   error: err.error,
    //   //   requestOptions: err.requestOptions,
    //   //   response: err.response,
    //   //   type: err.type,
    //   // );
    //   default:
    // }

    handler.next(err);
  }
}
