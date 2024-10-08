
import 'package:event_planner/pages/event/event_navigation_page.dart';
import 'package:event_planner/pages/home/main_navigation_page.dart';
import 'package:event_planner/pages/login/signup_page.dart';
import 'package:event_planner/services/event_services.dart';
import 'package:event_planner/services/payment_services.dart';
import 'package:event_planner/services/task_services.dart';
import 'package:event_planner/services/user_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/custom_scrollbar.dart';
import 'pages/login/login_page.dart';


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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserServices(), lazy: false,),
        ChangeNotifierProvider(create: (_) => EventServices(), lazy: false,),
        ChangeNotifierProvider(create: (_) => TaskServices(), lazy: false,),
        ChangeNotifierProvider(create: (_) => PaymentServices(), lazy: false,)],
      
      child: MaterialApp(
        title: 'Event Planner',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 45, 139, 167)),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
            '/login':(context) => LoginPage(),
            '/mainNav' :(context) => const MainNavigationPage(),
            '/signup':(context) => SignUpPage(),
            '/event':(context) => EventNavigationPage(),
        },     
        debugShowCheckedModeBanner: false,
        scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      ),
    );
  }
}


