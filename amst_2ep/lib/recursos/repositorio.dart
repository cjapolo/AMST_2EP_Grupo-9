
import 'dart:async';

import 'package:amst_2ep/modelos/auth_model.dart';
import 'package:amst_2ep/recursos/auth_token_provider.dart';
import 'package:amst_2ep/recursos/auth_provider.dart';

class RepositoryAuthorization {
  final authorizationCodeApiProvider = AuthorizationApiProvider();
  final authorizationTokenApiProvider = AuthorizationTokenApiProvider();
  Future<String>? fetchAuthorizationCode() => authorizationCodeApiProvider.fetchCode();
  Future<AuthorizationModel> fetchAuthorizationToken(String code) => authorizationTokenApiProvider.fetchToken(code);
}
