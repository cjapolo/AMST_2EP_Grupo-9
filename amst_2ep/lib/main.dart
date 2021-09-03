import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      );
    } else {
      return MaterialApp(
        title: 'Spotify Player',
        theme: tema,
        home: SongList(),
        debugShowCheckedModeBanner: false,
      );
    }
  }
}

class LoginSpotify extends StatelessWidget {
  const LoginSpotify({Key? key}) : super(key: key);

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
                key:null, onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SongList()),
                  );
                },
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

