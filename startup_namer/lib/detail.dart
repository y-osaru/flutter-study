import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget{
  final WordPair _pair;

  DetailWidget(this._pair);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('Detail'),
      ),
      body:Text(_pair.asPascalCase),
    );
  }
}