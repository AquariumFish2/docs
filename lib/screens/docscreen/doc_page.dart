
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample/screens/app_bar_button.dart';
import 'package:sample/screens/docscreen/add_doc.dart';
import 'widgets/doc_sample.dart';

class DocList extends StatelessWidget {
  const DocList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //contactType _contactType;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدكاترة'),
        actions: [
          AppBarButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddDoctor(),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        color: Colors.red[300],
                      ),
                      const Text('phone'),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        color: Colors.blue[300],
                      ),
                      const Text('email address'),
                    ],
                  )
                ],
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('doctors')
                    .get()
                    .asStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Map<String,Object> data=snapshot.data!.docs.forEach((element) { });
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                      final Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return DocSample(
                        docName: data['name'],
                        agreed: data['agreed'],
                        docType: data['type'],
                        id: document.id,
                        docNum: document['phone'],
                        hint: document['hint'],
                        patients: document['patients'],
                      );
                    }).toList());
                  }
                  return const Text('لا توجد دكاتره');
                })
          ],
        ),
      ),
    );
  }
}
