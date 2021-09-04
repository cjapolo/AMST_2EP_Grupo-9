
import 'authorizationModel.dart';

import 'repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthorizationBloc {
  final _repository = RepositoryAuthorization();

  final PublishSubject _authorizationTokenFetcher = PublishSubject<AuthorizationModel>();
  final PublishSubject _authorizationCodeFetcher = PublishSubject<String>();

  Stream get authorizationCode => _authorizationCodeFetcher.stream;
  Stream get authorizationToken => _authorizationTokenFetcher.stream;

  fetchAuthorizationCode() async {
    String? code = await _repository.fetchAuthorizationCode();
    _authorizationCodeFetcher.sink.add(code);
  }

  fetchAuthorizationToken(String code) async {
    AuthorizationModel authorizationModel = await _repository.fetchAuthorizationToken(code);
    _authorizationTokenFetcher.sink.add(authorizationModel);
  }

  disposeCode() {
    _authorizationCodeFetcher.close();
  }

  disposeToken() {
    _authorizationTokenFetcher.close();
  }
}

final AuthorizationBloc authorizationBloc = AuthorizationBloc();