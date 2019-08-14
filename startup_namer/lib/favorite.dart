import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class FavoriteWidget extends StatelessWidget{
  final Set<WordPair> _saved;
  final _biggerFont = const TextStyle(fontSize:18.0);
  
  FavoriteWidget(this._saved);

  @override
  Widget build(BuildContext context){
    final tiles = _saved.map(
      (WordPair pair){
        return ListTile(
          title: Text(pair.asPascalCase,style:_biggerFont),
        );
      }
    );

    final divided = ListTile.divideTiles(
      context: context,
      tiles:tiles,
    ).toList();

    return Scaffold(
      appBar:AppBar(
        title:Text('Saved Suggestions'),
      ),
      body:ListView(children:divided,),
    );
  }
}

