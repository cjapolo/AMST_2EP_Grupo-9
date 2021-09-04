import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'authorizationBloc.dart';
import 'menu.dart';
import 'tema.dart';

void main() {
  runApp(MyApp());
}

late Future<Profile> futureProfile = fetchProfile();

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
          '/profile': (BuildContext context) => new UserProfile(key, futureProfile),
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
          '/profile': (BuildContext context) => new UserProfile(key, futureProfile),
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
                MaterialPageRoute(builder: (context) => new  UserProfile(key, futureProfile)),
              );
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}

Future<Profile> fetchProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');

  final response = await http
      .get(Uri.parse('https://api.spotify.com/v1/me'),
      headers: {'Authorization' : "Bearer " + token!,
                'Accept' : "application/json"});

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Profile.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    // throw Exception('Failed to load profile');
    return new Profile(display_name: "display_name", folowers_total: 20, image_url: "https://source.unsplash.com/random/250x250");
  }
}

class Profile {
  final String display_name;
  final int folowers_total;
  final String image_url;

  Profile({
    required this.display_name,
    required this.folowers_total,
    required this.image_url,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      display_name: json['display_name'],
      folowers_total: json['followers']['total'],
      image_url: json['images'][0]['url'],
    );
  }
}

class UserProfile extends StatelessWidget {

  late Future<Profile> profile;

  UserProfile(Key? key, Future<Profile> profile){
    this.profile = profile;
  }

  static const _actionTitles = ['LogOut', 'Canciones', 'Detalles Usuario'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        new Center(
          child:
          new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              <Widget>[
                FutureBuilder<Profile>(
                  future: profile,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return new Image.network(
                        snapshot.data!.image_url,
                        fit:BoxFit.fill,
                        width: 150.0,
                        height: 150.0,
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
                FutureBuilder<Profile>(
                  future: profile,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return new Text(
                        snapshot.data!.display_name,
                        style: new TextStyle(fontSize:42.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w300,
                            fontFamily: "Roboto"),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const Text('Algo salió mal');
                  },
                ),
                FutureBuilder<Profile>(
                  future: profile,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return new Text(
                        (snapshot.data!.folowers_total).toString(),
                        style: new TextStyle(fontSize:29.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const Text('Algo salió mal');
                  },
                )
              ]
          ),
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

