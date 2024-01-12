import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phase_photo/components/button.dart';
import 'package:phase_photo/services/data_services.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key});

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final dataService = DataServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 79),
            child: Center(
              child: Container(
                child: GestureDetector(
                  // onTap: () => pickImage(id),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person,
                      size: 80.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 29),
            child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          buttons(
            colour: Colors.grey,
            title: 'Save',
            width: 300,
            height: 35,
            textColor: Colors.white,
            onPressed: () async {
              try {
                User? user = FirebaseAuth.instance.currentUser;
                String? oldUsername = user?.displayName;

                await user?.updateDisplayName(_usernameController.text);
                await user?.verifyBeforeUpdateEmail(_emailController.text);

                await dataService.updateImagesUploader(
                    oldUsername!, _usernameController.text);
                await user?.reload();

                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
