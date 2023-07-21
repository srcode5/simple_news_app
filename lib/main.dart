import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:developer';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic News Feed',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic News Feed'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('articles').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot);
            return Text('N/A');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView.separated(
            itemCount: snapshot.data?.docs.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: Colors.black); // Separator Divider
            },
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
              Map<String, dynamic>? data =
              document?.data() as Map<String, dynamic>?;
              return Padding(
                padding: const EdgeInsets.all(8.0), // Padding for each item
                child: InkWell(
                  onTap: () => _launchURL(data?['url'] ?? ''),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Image.network(data?['thumbnail'] ?? ''),
                        SizedBox(height: 10),
                        Text(data?['headline'] ?? ''),
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

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
