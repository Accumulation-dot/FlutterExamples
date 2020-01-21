import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final _list = <WordPair>[];

  final _fav = Set<WordPair>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushAction,)
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          if (index.isOdd) 
            return Divider();

          final i = index ~/ 2;
          if (i >= _list.length) {
            _list.addAll(generateWordPairs().take(10));
          }
          return _widgetForPair(_list[i]);
        },
      ),
    );
  }

  Widget _widgetForPair(WordPair pair) {
    final _faved = _fav.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase), 
      trailing: Icon(
        _faved ? Icons.favorite : Icons.favorite_border, 
        color: _faved ? Colors.red : null,),
        onTap: () {
          setState(() {
            if (_faved) {
              _fav.remove(pair);
            } else {
              _fav.add(pair);
            }
          });
        },
        );
  }

  void _pushAction() {
    Navigator.of(context).push(
      MaterialPageRoute(
      builder: (context) {
        final tiles = _fav.map(
          (pair) {
            return ListTile(
              title: Text(
                pair.asPascalCase,
              ),
            );
          },
        );
        final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
        return Scaffold(
          appBar: AppBar(
            title: Text('Saved Suggestions'),
          ),
          body: ListView(children: divided),
        );
      },
    ),
    );
  }
}