import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pages/event_page.dart';
// import 'pages/login_page.dart';

// import 'pages/login_page.dart';


void main() async {

  var options = const FirebaseOptions(
      apiKey: "AIzaSyCgAKXhQXoWV2eHy_KniagLtgcDEGsc_tQ",
      authDomain: "event-planner-fec61.firebaseapp.com",
      projectId: "event-planner-fec61",
      storageBucket: "event-planner-fec61.appspot.com",
      messagingSenderId: "371694358131",
      appId: "1:371694358131:web:1d45240a85315794512406",
      measurementId: "G-RCKM9N3EN1"
  );
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb){
    await Firebase.initializeApp(options: options);
  } else  {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 45, 139, 167)),
        useMaterial3: true,
      ),
      // home: LoginPage()
      home: EventPage()
      
    );
  }
}



