import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:phase_photo/configuration/textField.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:phase_photo/services/data_services.dart';

class CreateHistory extends StatefulWidget {
  const CreateHistory({Key? key});

  @override
  State<CreateHistory> createState() => _CreateHistory();
}

class _CreateHistory extends State<CreateHistory> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final dataService = DataServices();
  // Define a list of categories
  List<String> categories = [
    'Abstract',
    'Architecture',
    'Black and White',
    'Food',
    'Sports',
    'Street',
    'Travel'
  ];

  File? selectedFile;
  //For web only
  // String? imagePath;
  PlatformFile? selectedFileWeb;

  String selectedCategory = 'Abstract';

  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        String? fileExtension = result.files.single.extension;
        if (fileExtension != null &&
            ['jpg', 'jpeg', 'png'].contains(fileExtension.toLowerCase())) {
          if (kIsWeb) {
            setState(() {
              selectedFileWeb = result.files.single;
              // print(selectedFileWeb!.bytes);
              // print(selectedFileWeb!.name);
              // print(selectedFileWeb!.path);
            });
          } else {
            setState(() {
              selectedFile = File(result.files.single.path!);
            });
          }
        } else {
          print('Invalid file type. Please select a JPG, JPEG, or PNG file.');
        }
      }
    } catch (e) {
      print('Error picking a file: $e');
    }
  }

  Future<String?> uploadFile() async {
    final _storageInstance = FirebaseStorage.instance;
    if (kIsWeb) {
      if (selectedFileWeb == null) {
        return 'File is null';
      } else {
        final fileName = selectedFileWeb!.name;
        final destination = 'files/';
        final imageBytes = selectedFileWeb!.bytes;

        try {
          final reference = _storageInstance
              .ref(destination)
              .child('image_uploaded/$fileName');

          await reference.putData(imageBytes!);

          String downloadUrl = await reference.getDownloadURL();
          print(downloadUrl);

          return downloadUrl;
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
          return 'Error occurred';
        }
      }
    } else {
      if (selectedFile == null) {
        return 'File is null';
      } else {
        final fileName = basename(selectedFile!.path);
        final destination = 'files/';

        try {
          final reference = _storageInstance
              .ref(destination)
              .child('image_uploaded/$fileName');
          await reference.putFile(selectedFile!);

          String downloadUrl = await reference.getDownloadURL();
          print(downloadUrl);

          return downloadUrl;
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
          return 'Error occurred';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              width: double.infinity,
              height: 316,
              color: Colors.grey[300],
              child: selectedFile == null && selectedFileWeb == null
                  ? Icon(
                      Icons.add_a_photo,
                      size: 60.0,
                    )
                  : kIsWeb
                      ? Image.memory(selectedFileWeb!.bytes!)
                      // ? Image.network(selectedFileWeb!.path!)
                      : Image.file(selectedFile!),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: judulController,
            decoration: costumeTextField.copyWith(
              hintText: "Judul",
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: deskripsiController,
            decoration: costumeTextField.copyWith(
              hintText: "Deskripsi",
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                String? imageUrl = await uploadFile();
                if (imageUrl == 'File is null') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'File kosong, silahkan pilih file terlebih dahulu'),
                    ),
                  );
                } else if (imageUrl == 'Error occurred') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Terjadi kesalahan saat upload file'),
                    ),
                  );
                } else {
                  Map<String, String> imageData = {
                    'judul': judulController.text,
                    'kategori': selectedCategory,
                    'deskripsi': deskripsiController.text,
                    'image_url': imageUrl!,
                  };

                  DocumentReference? addedDocument =
                      await dataService.addImage(imageData);

                  if (await addedDocument!.snapshots().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gagal menambahkan file'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Berhasil menambahkan file'),
                      ),
                    );

                    Navigator.pushReplacementNamed(context, 'home');
                  }
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                  ),
                );
              }
            },
            child: Text('Upload'),
          ),
        ],
      ),
    );
  }
}
