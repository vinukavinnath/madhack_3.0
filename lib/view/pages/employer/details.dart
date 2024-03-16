import 'package:async_and_await/constants.dart';
import 'package:async_and_await/view/widgets/hidden_drawer_employer.dart';
import 'package:async_and_await/view/widgets/primary_button.dart';
import 'package:async_and_await/view/widgets/secondary_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'databaseconnectionemp.dart';
import 'jobposting.dart';
import 'dart:io';

class Details extends StatefulWidget {
  final String docId;
  final String industry;
  final String category;
  final String jobposition;
  final String jobtype;
  final String workspace;
  final selectedLocation;
  final String minSalary;
  final String maxSalary;

  const Details({
    Key? key,
    required this.docId,
    required this.industry,
    required this.category,
    required this.jobposition,
    required this.jobtype,
    required this.workspace,
    required this.selectedLocation,
    required this.minSalary,
    required this.maxSalary,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final jobDescriptionController = TextEditingController();
  final requirementsController = TextEditingController();
  final responsibilitiesController = TextEditingController();
  final aboutCompanyController = TextEditingController();
  final companynameController = TextEditingController();
  String? imageUrl;

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _uploadImage(pickedImage.path);
      });
    }
  }

  Future<void> _uploadImage(String imagePath) async {
    // Add your code to upload the image to Firebase Storage
    // Here is a simple example of uploading an image using FirebaseStorage:
    File imageFile = File(imagePath);
    String imageName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference storageReference =
        FirebaseStorage.instance.ref().child('profile_images/$imageName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.whenComplete(() async {
      imageUrl = await storageReference.getDownloadURL();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Description',
          style: kHeading1TextStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.navigate_before,
            color: kDeepBlueColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/noise.webp',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: screenHeight,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/noise.webp',
              ),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              imageUrl != null
                  ? Image.network(imageUrl!)
                  : SizedBox(), // Display uploaded image if available
              SizedBox(height: 10),
              SecondaryButton(
                process: _pickImageFromGallery,
                title: 'Select Profile Image',
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: jobDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Job Description',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: requirementsController,
                decoration: InputDecoration(
                  labelText: 'Requirements',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: responsibilitiesController,
                decoration: InputDecoration(
                  labelText: 'Responsibilities',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: companynameController,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: aboutCompanyController,
                decoration: InputDecoration(
                  labelText: 'About Company',
                ),
              ),
              SizedBox(height: 40),
              PrimaryButton(
                process: () async {
                  String docId = widget.docId;
                  String jobImageUrl = imageUrl ?? '';

                  FirebaseOperations.addDataToFirebase(
                    context,
                    docId,
                    widget.industry,
                    widget.category,
                    widget.jobposition,
                    widget.jobtype,
                    widget.workspace,
                    widget.selectedLocation,
                    widget.minSalary,
                    widget.maxSalary,
                    jobDescriptionController.text,
                    requirementsController.text,
                    responsibilitiesController.text,
                    companynameController.text,
                    aboutCompanyController.text,
                    jobImageUrl, // Pass the image URL to Firestore
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HiddenDrawerEmployer(),
                    ),
                  );
                },
                title: 'Post Job',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
