import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phase_photo/configuration/textField.dart';

class CreateHistory extends StatefulWidget {
  const CreateHistory({Key? key});

  @override
  State<CreateHistory> createState() => _CreateHistory();
}

class _CreateHistory extends State<CreateHistory> {
  final currentUser = FirebaseAuth.instance.currentUser;

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

  String selectedCategory = 'Abstract';

  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Icon(
                Icons.add_a_photo,
                size: 60.0,
              ),
              width: double.infinity,
              height: 316,
              color: Colors.grey[300],
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
            onPressed: () {
              // Add your upload logic here
            },
            child: Text('Upload'),
          ),
        ],
      ),
    );
  }
}
