import 'dart:async';
import 'authorizationModel.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class AuthorizationTokenApiProvider {
  Client client = Client();
  static String client_id = "c5b5c396081b492a833f21df57698400";
  static String client_secret ="e7323e189657403db7a48e42dee448fd";

  static String AuthorizationStr = "$client_id:$client_secret";
  static var bytes = utf8.encode(AuthorizationStr);
  static var base64Str = base64.encode(bytes);

  String Authorization= 'Basic ' + base64Str;

  var urlToToken = 'https://accounts.spotify.com/api/token';

  Future<AuthorizationModel> fetchToken(String code) async {
    var response = await client.post(Uri.parse(urlToToken), body: {
      'grant_type': "authorization_code",
      'code': code,
      'redirect_uri': 'cbname:/'
    },headers: {'Authorization' : Authorization});

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return AuthorizationModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}