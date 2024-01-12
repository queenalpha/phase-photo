import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:phase_photo/components/button.dart';
import 'package:phase_photo/configuration/textField.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:phase_photo/services/data_services.dart';

class CreatePhoto extends StatefulWidget {
  const CreatePhoto({this.imageId, Key? key});
  final String? imageId;
  @override
  State<CreatePhoto> createState() => _CreatePhoto();
}

class _CreatePhoto extends State<CreatePhoto> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final dataService = DataServices();
  bool isEditing = false;
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

  DocumentSnapshot? imageSnapshot;
  File? selectedFile;
  //For web only
  // String? imagePath;
  PlatformFile? selectedFileWeb;

  String selectedCategory = 'Abstract';

  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  Future<void> getImageData() async {
    DocumentReference? imageData =
        await dataService.getImageById(widget.imageId!);

    await imageData!.get().then((DocumentSnapshot documentSnapshot) {
      setState(() {
        imageSnapshot = documentSnapshot;

        selectedCategory = imageSnapshot!.get('kategori');
        judulController.text = imageSnapshot!.get('judul');
        deskripsiController.text = imageSnapshot!.get('deskripsi');

        isEditing = true;
      });
    });
  }

  Future<void> setCategory() async {
    if (widget.imageId != null) {
      setState(() {
        selectedCategory = imageSnapshot!.get('kategori');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.imageId != null) {
      getImageData();
    }
  }

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
              child: widget.imageId != null && imageSnapshot != null
                  ? Image.network(imageSnapshot!.get('image_url'))
                  : selectedFile == null && selectedFileWeb == null
                      ? Icon(
                          Icons.add_a_photo,
                          size: 60.0,
                        )
                      : kIsWeb
                          ? Image.memory(selectedFileWeb!.bytes!)
                          : Image.file(selectedFile!),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: judulController,
            decoration: costumeTextField.copyWith(
              hintText: '${imageSnapshot?.get('judul') ?? "Judul"}',
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
              hintText: '${imageSnapshot?.get('deskripsi') ?? "Deskripsi"}',
            ),
          ),
          SizedBox(height: 20),
          buttons(
            onPressed: () async {
              print(isEditing);
              try {
                if (isEditing) {
                  Map<String, String> updateImage = {
                    'judul': judulController.text,
                    'kategori': selectedCategory,
                    'deskripsi': deskripsiController.text,
                  };

                  bool status = await dataService.updateImage(
                      widget.imageId!, updateImage);
                  print(status);
                  if (!status) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gagal mengubah file'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Berhasil mengubah file'),
                      ),
                    );
                    setState(() {
                      isEditing = false;
                    });
                    Navigator.pushReplacementNamed(context, 'home');
                  }
                } else {
                  String? imageUrl = await uploadFile();
                  String? imageName;

                  if (kIsWeb) {
                    imageName = selectedFileWeb!.name;
                  } else {
                    imageName = basename(selectedFile!.path);
                  }

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
                    String username =
                        FirebaseAuth.instance.currentUser!.displayName!;

                    Map<String, String> imageData = {
                      'judul': judulController.text,
                      'kategori': selectedCategory,
                      'deskripsi': deskripsiController.text,
                      'image_url': imageUrl!,
                      'uploader': username,
                      'image_name': imageName,
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
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                  ),
                );
              }
            },
            colour: Colors.grey,
            title: 'Upload',
            width: 300,
            height: 35,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
