// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/services/event_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/task_services.dart';
import '../../services/user_services.dart';
import '../event/event_navigation_page.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text(
        'Events',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
      // backgroundColor: Colors.blue[100], // Set your desired background color here
    ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer2<UserServices, EventServices>(
                builder: (context, userServices, eventServices, child) {
                  return StreamBuilder(
                    stream: eventServices.fetchEvents(userServices.appUser),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {
                                print('object');
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => EditEventScreen(event: ds),
                                //   ),
                                // );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 5), // Increased margin for better spacing
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8.0),
                                  onTap: () {
                                    print('Card tapped');
                                  },
                                  onLongPress: () {
                                    print('Card long pressed');
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 168, 217, 255),
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(255, 161, 194, 255).withOpacity(0.2),
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0), // Added more padding
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${ds['title']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,),),
                                            Text('${ds['date']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,),),
                                            Text('${ds['description']}', style: const TextStyle(fontSize: 14.0),),
                                            Text('${ds['userId']}', style: const TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 58, 51, 51)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EventNavigationPage(),
            ),
          );
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}
