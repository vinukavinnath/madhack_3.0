import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> _usersCollection =
  FirebaseFirestore.instance.collection('User');

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> updateUserData({
    required String userUid,
    required String fullName,
    required String dob,
    required String email,
    required String phoneNumber,
    File? profileImage,
    // Add other necessary parameters
  }) async {
    try {
      String imageUrl = '';

      if (profileImage != null) {
        String filePath = 'profile_images/$userUid.jpg';

        // Upload the profile image to Firebase Storage
        await _storage.ref(filePath).putFile(profileImage);

        // Get the download URL
        imageUrl = await _storage.ref(filePath).getDownloadURL();
      }

      // Update user data in Firestore
      await _usersCollection.doc(userUid).update({
        'user_fullname': fullName,
        'user_dob': dob,
        'user_email': email,
        'user_mobile': phoneNumber,
        'user_profileimage': imageUrl,
        // Add other fields you want to update
      });

      print('User data updated successfully!');
    } catch (error) {
      print('Error updating user data: $error');
      // Handle error as needed
    }
  }
}

class UpdateAboutPage extends StatefulWidget {
  final String userUid;
  final TextEditingController fullNameController;
  final TextEditingController dobController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;

  const UpdateAboutPage({
    required this.userUid,
    required this.fullNameController,
    required this.dobController,
    required this.emailController,
    required this.phoneNumberController,
  });

  @override
  State<UpdateAboutPage> createState() => _UpdateAboutPageState();
}

class _UpdateAboutPageState extends State<UpdateAboutPage> {
  File? _imageFile;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        print('Image picked successfully: ${pickedFile.path}');
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : AssetImage(' ') as ImageProvider<Object>,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Update your profile information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: widget.fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: widget.dobController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
              ),
              TextField(
                controller: widget.emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: widget.phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await FirestoreService().updateUserData(
                    userUid: widget.userUid,
                    fullName: widget.fullNameController.text,
                    dob: widget.dobController.text,
                    email: widget.emailController.text,
                    phoneNumber: widget.phoneNumberController.text,
                    profileImage: _imageFile,
                    // Add other necessary parameters
                  );
                  // Optionally, you can navigate back or show a success message
                  Navigator.pop(context);
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
