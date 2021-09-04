import 'dart:async';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' show Client;

class AuthorizationApiProvider {
  Client client = Client();

  static String url = "https://accounts.spotify.com/authorize";
  // TODO: Proper Scheme
  static String client_id = "YOURCLIENTIDHERE";
  static String response_type = "code";
  // TODO: Proper Scheme
  static String redirect_uri = "NAME:/";
  static String scope =
      "playlist-read-private playlist-read-collaborative";
  static String state = "34fFs29kd09";

  String urlDireccion = "$url" +
      "?client_id=$client_id" +
      "&response_type=$response_type" +
      "&redirect_uri=$redirect_uri" +
      "&scope=$scope" +
      "&state=$state";

  Future<String?> fetchCode() async {
    final response = await FlutterWebAuth.authenticate(
        // TODO: Proper Scheme
        url: urlDireccion, callbackUrlScheme: "NAME");
    final error = Uri.parse(response).queryParameters['error'];
    if (error == null) {
      final code = Uri.parse(response).queryParameters['code'];
      return code;
    } else {
      print("Error al autenticar");
      return error;
    }
  }
}