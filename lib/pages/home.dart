import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _items = [
    "assets/analog.jpg",
    "assets/bird.jpg",
    "assets/man with a cap.jpg",
    "assets/man with shadow.jpg",
    "assets/plant.jpg",
    "assets/sofia building.jpg",
    "assets/boy.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PHASE",
            style: TextStyle(
              color: Colors.black,
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: MasonryGridView.builder(
        itemCount: _items.length,
        gridDelegate:
            SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(_items[index])),
          );
        },
      ),
    );
  }
}
