import 'dart:async';
import 'dart:convert';
import 'package:booking_system/models/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../config/app_config.dart';

class AuthenticateUser with ChangeNotifier{

  final TokenStorage _tokenStorage;
  bool _isAuthenticated = false;

  AuthenticateUser(this._tokenStorage){
    updateIsAuthenticated();
  }

  bool get isAuthenticated => _isAuthenticated;

  void setIsAuthenticated(bool state){
    _isAuthenticated = state;
    notifyListeners();
  }

  Future<void> updateIsAuthenticated() async{
    if (await _tokenStorage.getJwtToken() != null){
      setIsAuthenticated(true);
    }
  }

  Future<bool> authenticate(String email, String password) async{
    final url = Uri.parse(AppConfig.authenticateUrl);
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));

    try{
      final response = await http.post(
        url, 
        headers: <String, String>{'Authorization': basicAuth,}
      );

      if(response.statusCode == 200){
        final jsonResponse = json.decode(response.body);
        final token = jsonResponse['data']?['token'];
        final refreshToken = jsonResponse['data']?['refresh_token'];

        await _tokenStorage.storeTokens(token, refreshToken);
        setIsAuthenticated(true);
        return true;
        //Need to add conditions for error codes
      }else{
        setIsAuthenticated(false);
        return false;
        //throw Exception('Failed to authenticate : ${response.body}');
    }
    } catch (error){
      throw Exception('Failed to authenticate : $error');
    }
  }

  Future<String?> refreshJwtToken() async{
    print("Refresh");
    String? refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken != null && !_tokenStorage.isJwtExpired(refreshToken)){
      final url = Uri.parse(AppConfig.refreshTokenUrl);
      try{
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {'refresh_token': refreshToken}
        );
        if (response.statusCode == 200){
          final responseBody = json.decode(response.body);
          final newJwtToken = responseBody['data']?['token'];
          final newRefreshToken = responseBody['data']?['refresh_token'];
          await _tokenStorage.storeTokens(newJwtToken, newRefreshToken);
          return newJwtToken;
          //Need to add conditions for error codes
        }else{
          setIsAuthenticated(false);
          throw Exception('Failed to authenticate : ${response.body}');
        }
      }catch(error){
        throw Exception('Failed to refresh Token : $error');
      }
    }
    return null; //Redirect to login 
  }

  Future<void> logOut() async{
    _tokenStorage.clearTokens();
    setIsAuthenticated(false);
  }
}