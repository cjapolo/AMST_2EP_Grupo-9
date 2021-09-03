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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: tema,
      home: SongList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

@immutable
class SongList extends StatelessWidget {
  static const _actionTitles = ['LogOut', 'Canciones', 'Detalles Usuario'];

  const SongList({Key? key}) : super(key: key);

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

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
            onPressed: () => _showAction(context, 0),
            icon: const Icon(Icons.logout),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 1),
            icon: const Icon(Icons.library_music_outlined),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 2),
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
    );
  }
}

