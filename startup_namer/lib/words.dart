import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/favorite.dart';
import 'package:startup_namer/detail.dart';

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize:18.0);

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
      trailing: IconButton(
        icon:Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
        ),
        onPressed: (){
          setState((){
              if(alreadySaved){
                _saved.remove(pair);
              }else{
                _saved.add(pair);
              }
          });
        },
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder:(BuildContext context){
              return DetailWidget(pair);
            }
          ),
        );
      },
    );
  }
  
  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          return FavoriteWidget(_saved);
        },
      ),
    );
  }
}