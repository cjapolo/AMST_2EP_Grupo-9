
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
    if(_isDisposedCode) {
      return;
    }
    String? code = await _repository.fetchAuthorizationCode();
    _authorizationCodeFetcher.sink.add(code);
  }

  fetchAuthorizationToken(String code) async {
    if(_isDisposedToken) {
      return;
    }
    AuthorizationModel authorizationModel = await _repository.fetchAuthorizationToken(code);
    _authorizationTokenFetcher.sink.add(authorizationModel);
  }

  bool _isDisposedCode = false;
  disposeCode() {
    _authorizationCodeFetcher.close();
    _isDisposedCode = true;
  }

  bool _isDisposedToken = false;
  disposeToken() {
    _authorizationTokenFetcher.close();
    _isDisposedToken = true;
  }
}

final AuthorizationBloc authorizationBloc = AuthorizationBloc();