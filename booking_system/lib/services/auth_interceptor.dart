import 'package:booking_system/src/authentication/services/authenticate_user.dart';
import 'package:dio/dio.dart';
import '../models/token_storage.dart';

class AuthInterceptor extends Interceptor{
  final TokenStorage _tokenStorage;
  final AuthenticateUser _authenticateUser;

  AuthInterceptor(this._tokenStorage, this._authenticateUser);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    String? jwtToken = await _tokenStorage.getValidToken();
    
    jwtToken ??= await _authenticateUser.refreshJwtToken();

    if(jwtToken != null){
      options.headers['Authorization'] = 'Bearer $jwtToken';
      return handler.next(options);
    } else{
      return handler.reject(DioException(
        requestOptions: options,
        type: DioExceptionType.cancel,
        error: 'Authentication  Failed',
      ));
    }

  }
}