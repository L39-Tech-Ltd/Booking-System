
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenStorage{

  final _storage = FlutterSecureStorage();
  static const _jwtKey = 'jwt_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> storeTokens(String jwtToken, String refreshToken) async{
    await _storage.write(key: _jwtKey, value: jwtToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getJwtToken() async{
    return await _storage.read(key: _jwtKey);
  }

  Future<String?> getRefreshToken() async{
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> clearTokens() async{
    await _storage.delete(key: _jwtKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  bool isJwtExpired(String jwt){
    return JwtDecoder.isExpired(jwt);
  }

  Future<String?> getValidToken() async{
    String? jwtToken = await getJwtToken();
    if(jwtToken != null && !isJwtExpired(jwtToken)){
      return jwtToken;
    }
    return null;
  }

}