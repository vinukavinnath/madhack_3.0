import 'package:async_and_await/view/pages/user/dashboard/WorkExperience.dart';
import 'package:async_and_await/view/pages/user/dashboard/aboutme.dart';
import 'package:async_and_await/view/pages/user/dashboard/education.dart';
import 'package:async_and_await/view/pages/user/dashboard/qualifications.dart';
import 'package:async_and_await/view/pages/user/dashboard/skills.dart';
import 'package:async_and_await/view/widgets/secondary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  DashBoard({
    Key? key,
  }) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> userStream;
  String fullName = ''; // Declare fullName outside the build method

  @override
  void initState() {
    super.initState();
    userStream = FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: userStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == null ||
                        snapshot.data!.data() == null) {
                      return Text('User data not available');
                    } else {
                      var userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      String profileImageUrl =
                          userData['user_profileimage'] ?? '';
                      fullName = userData?['user_fullname'] ??
                          ''; // Assign value to fullName

                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: profileImageUrl.isNotEmpty
                            ? NetworkImage(profileImageUrl)
                            : AssetImage('assets/default_image.jpg')
                                as ImageProvider, // Replace with your default image asset
                      );
                    }
                  },
                ),
                SizedBox(height: 10),
                Text(
                  '$fullName', // Use fullName here
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SecondaryButton(
                    process: () {},
                    title: 'Update Profile',
                  ),
                ),
                ListTile(
                  title: Text('About me'),
                  trailing: Icon(Icons.add),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutMe()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Work experience'),
                  trailing: Icon(Icons.add),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WorkExperience()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Education'),
                  trailing: Icon(Icons.add),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Education()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Skills'),
                  trailing: Icon(Icons.add),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Skills()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Qualifications'),
                  trailing: Icon(Icons.add),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Qualifications()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
