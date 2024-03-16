import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcceptPage extends StatelessWidget {
  final String docId;

  const AcceptPage({Key? key, required this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accept Page'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Jobs')
            .doc(docId)
            .collection('applyinfo')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to a new page when card is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsPage(
                        userEmail: document['userEmail'],
                        cv: document['cv'],
                        message: document['message'],
                        feedback: document['feedback'],
                      ),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text('${document['userEmail']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CV: ${document['cv']}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UserDetailsPage extends StatelessWidget {
  final String userEmail;
  final String cv;
  final String message;
  final String? feedback; // Making feedback nullable

  const UserDetailsPage({
    Key? key,
    required this.userEmail,
    required this.cv,
    required this.message,
    this.feedback, // Making feedback nullable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('User Email'),
            subtitle: Text(userEmail),
          ),
          ListTile(
            title: Text('CV'),
            subtitle: Text(cv),
          ),
          ListTile(
            title: Text('Message'),
            subtitle: Text(message),
          ),
          ListTile(
            title: Text('Feedback'),
            subtitle: Text(feedback ?? 'Not provided'),
          ),
        ],
      ),
    );
  }
}
