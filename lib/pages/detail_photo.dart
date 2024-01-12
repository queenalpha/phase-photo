import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DetailPhoto extends StatefulWidget {
  const DetailPhoto({Key? key});

  @override
  State<DetailPhoto> createState() => _Detail();
}

class _Detail extends State<DetailPhoto> {
  final currentUser = FirebaseAuth.instance.currentUser;

  File? selectedFile;

  String selectedCategory = 'Abstract';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
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
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                color: Colors.grey[300],
                height: 500,
                child:
                    // Image.network(
                    //   'image_url',
                    //   fit: BoxFit.cover,
                    // ),
                    Icon(Icons.photo_outlined, color: Colors.grey, size: 100),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 5, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@${currentUser!.displayName}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Judul Foto',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 5),
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
                      // bottom: 20,
                      // right: 20,
                      child: FloatingActionButton(
                        onPressed: () {
                          // Implementasi bookmark
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
