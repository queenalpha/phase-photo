import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phase_photo/pages/add_photo.dart';
import 'package:phase_photo/services/data_services.dart';

class DetailPhoto extends StatefulWidget {
  final String imageId;

  const DetailPhoto({required this.imageId});

  @override
  State<DetailPhoto> createState() => _Detail();
}

class _Detail extends State<DetailPhoto> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final dataService = DataServices();

  File? selectedFile;

  String selectedCategory = 'Abstract';

  bool showDropdownIcon = false; // Variable to control visibility

  // DocumentReference? image;

  DocumentSnapshot? imageSnapshot;

  Future<void> checkImage() async {
    if (imageSnapshot != null) {
      if (currentUser!.displayName == imageSnapshot!.get('uploader')) {
        setState(() {
          showDropdownIcon = true;
        });
      }
    }
  }

  Future<void> getImageData() async {
    DocumentReference? imageData =
        await dataService.getImageById(widget.imageId);

    await imageData!.get().then((DocumentSnapshot documentSnapshot) {
      setState(() {
        imageSnapshot = documentSnapshot;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getImageData();
  }

  @override
  Widget build(BuildContext context) {
    checkImage();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${imageSnapshot?.get('judul') ?? "Title"}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(width: 3),
              // Placeholder for category
              Text(
                '${imageSnapshot?.get('kategori') ?? "Nama kategori"}',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[300],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: SizedBox(),
        ),
        actions: [
          // if (showDropdownIcon)
          // IconButton(
          //   icon: Icon(Icons.arrow_drop_down),
          //   onPressed: () {
          //     // Implement your dropdown logic here
          //   },
          // ),
          // Delete option using PopupMenuButton
          if (showDropdownIcon)
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'Update') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePhoto(
                        imageId: widget.imageId,
                      ),
                    ),
                  );
                }
                if (value == 'Delete') {
                  String deleteStatus = await dataService.deleteImage(
                    widget.imageId,
                    imageSnapshot?.get('image_name'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(deleteStatus),
                    ),
                  );

                  Navigator.pushReplacementNamed(context, 'home');
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'Update',
                  child: ListTile(
                    title: Text('Update'),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Delete',
                  child: ListTile(
                    title: Text('Delete'),
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                color: Colors.grey[300],
                height: 500,
                child: imageSnapshot != null
                    ? Image.network(imageSnapshot?.get('image_url'),
                        fit: BoxFit.cover)
                    : Icon(Icons.photo_outlined, color: Colors.grey, size: 100),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 5, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Placeholder for user
                    Text(
                      '@${imageSnapshot?.get('uploader') ?? "@Uploader"}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    // Placeholder for title
                    Text(
                      '${imageSnapshot?.get('judul') ?? "Judul Foto"}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 5),
                    // Placeholder for description
                    Text(
                      '${imageSnapshot?.get('deskripsi') ?? "Lorem ipsum is simply dummy text of the printing and typesetting industry"}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 150),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(330, 0, 0, 0),
                      child: FloatingActionButton(
                        onPressed: () {
                          // Implement bookmark functionality
                          // Add your logic here
                        },
                        backgroundColor: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(Icons.bookmark_border, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
