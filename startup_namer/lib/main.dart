// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  //Dartは型を書いても書かなくてもOK？
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize:18.0);

  Widget _builSuggestions(){
    
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,i){
        //iが奇数の時には仕切り線を表示
        if(i.isOdd) return Divider();

        final index = i ~/ 2;//iを2で割った商
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair){
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title:Text(pair.asPascalCase,style:_biggerFont),
      //trailingはListTileの右側に出るWidget
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      //TODO:このタップをIconに持たせるには？→IconButton？
      onTap: (){
        //setState()はFWが変更を検知したら呼ばれる
        setState((){
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon:Icon(Icons.list),onPressed: _pushSaved,)
        ],
      ),
      body: _builSuggestions(),
    );
  }

  void _pushSaved(){
    //Widgetをpushする。
    //TODO:ここの部分は別のStateに分ける事で分離になる？_savedをどう渡すのかが鍵かな。
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          final tiles = _saved.map(
            (WordPair pair){
              return ListTile(
                title:Text(pair.asPascalCase,style: _biggerFont,),
              );
          });
          final divided = ListTile.divideTiles(
            context: context,
            tiles:tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title:Text('Saved Suggestions'),
            ),
            body:ListView(children: divided,),
          );
        },
      ),
    );
  }
}