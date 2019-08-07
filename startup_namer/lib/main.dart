// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/semantics.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize:18.0);

  Widget _builSuggestions(){
    
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,i){
        print("i:" + i.toString());

        //iが奇数の時には仕切り線を表示
        if(i.isOdd) return Divider();

        final index = i ~/ 2;//iを2で割った商
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        
        //Q:このListViewの実行頻度ってどうなってるの？
        //→要素が描画されたタイミングで実行される？
        //→もしかして気にしたら負けなやつ？(内部で良しなにやってる？)
        print("index:" + index.toString());
        print("list length:" + _suggestions.length.toString());
        print("time:"+DateTime.now().toString());

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair){
    return ListTile(
      title:Text(pair.asPascalCase,style:_biggerFont),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('Startup Name Generator')
      ),
      body: _builSuggestions(),
    );
  }
}