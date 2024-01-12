import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailPhoto extends StatefulWidget {
  const DetailPhoto({Key? key});

  @override
  State<DetailPhoto> createState() => _Detail();
}

class _Detail extends State<DetailPhoto> {
  final currentUser = FirebaseAuth.instance.currentUser;

  File? selectedFile;

  String selectedCategory = 'Abstract';

  bool showDropdownIcon = false; // Variable to control visibility

  @override
  Widget build(BuildContext context) {
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
                'Title',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(width: 3),
              // Placeholder for category
              Text(
                'Nama kategori',
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
          if (showDropdownIcon)
            IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {
                // Implement your dropdown logic here
              },
            ),
          // Delete option using PopupMenuButton
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Update') {
               //logic
              }
              if (value == 'Delete') {
               //logic
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
                child: selectedFile != null
                    ? Image.file(selectedFile!, fit: BoxFit.cover)
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
                      '@${currentUser!.displayName}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    // Placeholder for title
                    Text(
                      'Judul Foto',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 5),
                    // Placeholder for description
                    Text(
                      'Lorem ipsum is simply dummy text of the printing and typesetting industry',
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
