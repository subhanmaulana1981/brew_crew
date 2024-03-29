import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<Iterable<Brew>>(context).toList();

    // print("brews collection: $brews.documents");
    /*for (var doc in brews.docs) {
      print(doc.data());
    }*/
    
    /*brews.forEach((brew) {
      print("name: ${brew.name}");
      print("sugars: ${brew.sugars}");
      print("strength: ${brew.strength}");
    });*/

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
