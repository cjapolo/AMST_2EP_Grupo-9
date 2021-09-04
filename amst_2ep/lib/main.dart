import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'authorizationBloc.dart';
import 'menu.dart';
import 'tema.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([]);
    if (1 == 1) {
      return MaterialApp(
        title: 'Spotify Player',
        theme: tema,
        home: LoginSpotify(),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/songs': (BuildContext context) => new SongList(),
          '/profile': (BuildContext context) => new UserProfile(),
        },
      );
    } else {
      return MaterialApp(
        title: 'Spotify Player',
        theme: tema,
        home: SongList(),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/songs': (BuildContext context) => new SongList(),
          '/profile': (BuildContext context) => new UserProfile(),
        },
      );
    }
  }
}

class AsynWait extends StatefulWidget {
  @override
  _AsynWait createState() => _AsynWait();
}

class _AsynWait extends State<AsynWait> {

  addTokenToSF(AsyncSnapshot<dynamic> snapshot) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', snapshot.data!.accessToken);
    prefs.setString('token_type', snapshot.data!.tokenType);
    prefs.setString('refresh_token', snapshot.data!.refreshToken);
    prefs.setBool('logged', true);
  }

  @override
  Widget build(BuildContext contextBuild) {
    authorizationBloc.fetchAuthorizationCode();

    _bienvenido() {
      authorizationBloc.disposeToken();
      Timer(Duration(microseconds: 0),
              () => Navigator.pushNamedAndRemoveUntil(context,"/songs", (route)=>false));
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: StreamBuilder(
        stream: authorizationBloc.authorizationCode,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "access_denied") {
              Navigator.pop(contextBuild);
            } else {
              authorizationBloc.fetchAuthorizationToken(snapshot.data);
              return StreamBuilder(
                stream: authorizationBloc.authorizationToken,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    print("FINAL DATA");
                    print('access_token: ${snapshot.data.accessToken}');
                    print("token_type: ${snapshot.data.tokenType}");
                    print("expires_in: ${snapshot.data.expiresIn}");
                    print("refresh_token: ${snapshot.data.refreshToken}");
                    print("scope: ${snapshot.data.scope}");
                    addTokenToSF(snapshot);
                    return _bienvenido();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class LoginSpotify extends StatelessWidget {
  const LoginSpotify({Key? key}) : super(key: key);

  // https://accounts.spotify.com/en/login?continue=https:%2F%2Faccounts.spotify.com%2Fauthorize%3Fscope%3Duser-read-private%2Buser-read-email%2Buser-read-playback-position%2Buser-library-read%2Buser-top-read%2Bplaylist-read-public%2Buser-follow-read%2Buser-read-playback-state%2Buser-read-currently-playing%2Bplaylist-read-private%2Bplaylist-read-collaborative%2Buser-read-recently-played%26response_type%3Dtoken%26redirect_uri%3Dhttps%253A%252F%252Fdeveloper.spotify.com%252Fcallback%26state%3Dy9vmyd%26client_id%3D774b29d4f13844c495f206cafdad9c86
  void _getToken(BuildContext context)
  {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AsynWait()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              'assets/spotify_logo.png',
              fit:BoxFit.fitHeight,
              width: 200.0,
              height: 200.0,
            ),
            new Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: new Text(
                "Iniciar Sesión en Spotify",
                style: new TextStyle(fontSize:25.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w300,
                    fontFamily: "Roboto"),
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: new ElevatedButton(
                key:null,
                onPressed: () { _getToken(context); },
                child: new Text(
                  "Iniciar Sesión",
                  style: new TextStyle(fontSize:22.0,
                      color: const Color(0xFFffffff),
                      fontWeight: FontWeight.w300,
                      fontFamily: "Roboto"),
                )
              ),
            ),
          ]
        ),
      ),
    );
  }
}

class SongList extends StatelessWidget {
  static const _actionTitles = ['LogOut', 'Canciones', 'Detalles Usuario'];

  const SongList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: 25,
        itemBuilder: (context, index) {
          return FakeItem(isBig: index.isOdd);
        },
      ),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginSpotify()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
          ActionButton(
            onPressed: () => {},
            icon: const Icon(Icons.library_music_outlined),
          ),
          ActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfile()),
              );
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  static const _actionTitles = ['LogOut', 'Canciones', 'Detalles Usuario'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: 25,
        itemBuilder: (context, index) {
          return FakeItem(isBig: index.isOdd);
        },
      ),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginSpotify()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
          ActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SongList()),
              );
            },
            icon: const Icon(Icons.library_music_outlined),
          ),
          ActionButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}

