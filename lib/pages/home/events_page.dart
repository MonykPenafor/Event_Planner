// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/services/event_services.dart';
import 'package:event_planner/services/task_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../components/custom_snackbar.dart';
import '../../models/event.dart';
import '../../services/user_services.dart';
import '../event/event_navigation_page.dart';

// ignore: must_be_immutable
class EventsPage extends StatelessWidget {

  EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        title: const Text('Events', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: Consumer3<UserServices, EventServices, TaskServices>(
                builder: (context, userServices, eventServices, taskServices,
                    child) {

                  return StreamBuilder(
                    stream: eventServices.fetchEvents(userServices.appUser),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {

                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = snapshot.data!.docs[index];
                            Event _event = Event.fromDocument(ds);

                            return GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.only(bottom:5), 
                                child: InkWell(borderRadius: BorderRadius.circular(8.0),
                                  onTap: () {

                                    taskServices.resetLocalTasks();

                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            EventNavigationPage(event: _event),
                                      ),
                                    );
                                  },

                                  onLongPress: () {
                                    
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(

                                          titlePadding: const EdgeInsets.only(
                                              top: 13.0, left: 13.0, right: 13),

                                          title: Row( mainAxisAlignment:MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.close),
                                                onPressed: () {Navigator.of(context).pop();},
                                              ),
                                            ],
                                          ),

                                          content: Row( mainAxisAlignment: MainAxisAlignment.center,
                                            children: [ Text( "Do you want to delete ${_event.title}"),],
                                          ),

                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () async {


                                                  var result = await eventServices.deleteEvent(_event.id);
                                                  
                                                  Navigator.of(context).pop();


                                                  print(result['message']);

                                                  CustomSnackBar.show(context, 
                                                    result['message'], 
                                                    result['success']
                                                  );
                                                },
                                                child: const Text("Delete")),
                                          ],
                                        );
                                      },
                                    );
                                  },

                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB( 255, 168, 217, 255),
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [ BoxShadow( 
                                        color: const Color.fromARGB( 255, 161, 194, 255).withOpacity(0.2),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                        ),
                                      ],
                                    ),

                                    child: Card(
                                      elevation: 0,
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0),),
                                      child: Padding( 
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text( 
                                              _event.title!,
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,),
                                            ),

                                            Text(
                                              _event.date != null ? DateFormat('dd/MM/yyyy')
                                                                  .format((ds['date'] as Timestamp)
                                                                  .toDate()) : '',
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,),
                                            ),

                                            Text(
                                              _event.description!,
                                              style: const TextStyle(fontSize: 14.0),
                                            ),

                                            Text(
                                              _event.userId!,
                                              style: const TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 58, 51, 51)),
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
                      } 

                      else 
                      {
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
          onPressed: () {Navigator.pushNamed(context, '/event');},
          child: const Icon(Icons.add)
      ),
    );
  }
}
