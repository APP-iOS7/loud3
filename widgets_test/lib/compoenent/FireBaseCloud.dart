import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireBaseCloud extends StatefulWidget {
  const FireBaseCloud({super.key});

  @override
  State<FireBaseCloud> createState() => _FireBaseCloudState();
}

class _FireBaseCloudState extends State<FireBaseCloud> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // 싱글 톤
  final String _collectionName = 'counters';
  final String _documentId = 'my_counter_id';

  void _incrementCounter() {
    _firestore.runTransaction((transaction) async {
      transaction.update(
        _firestore.collection(_collectionName).doc(_documentId),
        <String, dynamic>{'counter': FieldValue.increment(1)},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: StreamBuilder<DocumentSnapshot>(
            stream: _firestore
                .collection(_collectionName)
                .doc(_documentId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (!snapshot.hasData) {
                return const Text('Document does not exist');
              }
              print("snapshot Data : ${snapshot.data!.data()}");
              final data = snapshot.data!.data() as Map<String, dynamic>;
              final counter = data['counter'] as int;

              return Text(
                '$counter',
                style: Theme.of(context).textTheme.headlineLarge,
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment!',
          child: const Icon(Icons.plus_one),
        ));
  }
}
