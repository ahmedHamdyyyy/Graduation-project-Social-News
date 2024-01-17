import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../config/constants/api_constants/api_constants.dart';
import '../../../config/constants/app_constants/constants.dart';

class ApiServices {
  static late Dio dio;
  static const secureStorage = FlutterSecureStorage();
  static get initialize async {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 50000,
        receiveTimeout: 50000,
        sendTimeout: 50000,
      ),
    )..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = await secureStorage.read(key: 'token');
            if (token != null) {
              options.headers['Authorization'] = 'Bearer$token';
            }
            return handler.next(options);
          },
          onError: (e, handler) async {
            try {
              if (e.response == null || e.response!.data != 'Invalid Token') {
                return handler.next(e);
              }
              final refresh = await dio.post(
                refreshTokenEP,
                data: {'user_id': profileData.id},
              );
              secureStorage.write(
                key: 'token',
                value: refresh.data['refresh_token'],
              );
              e.requestOptions.headers['Authorization'] =
                  refresh.data['refresh_token'];
              await dio.request(
                e.requestOptions.path,
                options: Options(
                  method: e.requestOptions.method,
                  headers: e.requestOptions.headers,
                  receiveTimeout: e.requestOptions.receiveTimeout,
                  contentType: e.requestOptions.contentType,
                  responseType: e.requestOptions.responseType,
                ),
              );
            } on DioError catch (e) {
              if (kDebugMode) print(e);
              rethrow;
            } catch (e) {
              rethrow;
            }
            return handler.next(e);
          },
        ),
      );
  }
}

// class DioInterceptor extends Interceptor {
//   String? token;
//   final dio = ApiServices.dio;
//   @override
//   void onRequest(options, handler) async {
//     options.headers['Authorization'] = 'Bearer$token';
//     handler.next(options);
//     super.onRequest(options, handler);
//   }

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     if (err.response!.statusCode == 401) {
//       if (CacheServices().checkKey('token')) {
//         await refreshToken;
//         handler.resolve(await _retry(err.requestOptions));
//       }
//     }
//     handler.next(err);
//     super.onError(err, handler);
//   }

//   Future<Response> _retry(RequestOptions requestOptions) async => dio.request(
//         requestOptions.path,
//         data: requestOptions.data,
//         queryParameters: requestOptions.queryParameters,
//         options: Options(
//           method: requestOptions.method,
//           headers: requestOptions.headers,
//         ),
//       );

//   Future<void> get refreshToken async {
//     final token = getToken;
//     final response = await dio.post(refreshTokenEP, data: {'token': token});
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       this.token = token;
//     } else {
//       this.token = null;
//       await CacheServices().remove('token');
//     }
//   }

//   String? get getToken => CacheServices().getString('token');
// }
