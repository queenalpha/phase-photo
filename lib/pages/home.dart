import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:phase_photo/pages/detail_photo.dart';
import 'package:phase_photo/services/data_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dataService = DataServices();

  late Stream<List<DocumentSnapshot>> _imagesStream;

  @override
  void initState() {
    super.initState();
    _imagesStream = dataService.getAllImages().asStream();
  }

  Future<void> refreshData() async {
    setState(() {
      _imagesStream = dataService.getAllImages().asStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    // refreshData();
    return Scaffold(
      appBar: AppBar(
        title: Text("PHASE",
            style: TextStyle(
              color: Colors.black,
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: _imagesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Gallery kosong',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Gallery kosong',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            List<DocumentSnapshot> imagesSnapshot = snapshot.data!;
            print(imagesSnapshot.length);
            return MasonryGridView.builder(
              itemCount: imagesSnapshot.length,
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(imagesSnapshot.elementAt(index).id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPhoto(
                          // imageId: 'alzvrMK1OlGkwKuuz5Ff',
                          imageId:
                              imagesSnapshot.elementAt(index).id.toString(),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      // child: Image.asset(_items[index]),
                      child: Image.network(
                        imagesSnapshot.elementAt(index).get('image_url'),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
