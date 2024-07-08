import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/services/event_list_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../event/event_navigation_page.dart';

class EventsPage extends StatelessWidget {
  EventsPage({super.key});
  final EventListServices _eventListServices = EventListServices();

  @override
  Widget build(BuildContext context) {

User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: StreamBuilder(
          stream: _eventListServices.getEvents(currentUser),
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return Card(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('${ds['title']}'),
                          Text('${ds['title']}'),
                          Text('${ds['userId']}')
                        ]));
                  });
            } else {
              return Container();
            }
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EventNavigationPage(),
              ));
        },
        child: const Text(
          "+",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
