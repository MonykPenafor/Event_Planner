import 'package:event_planner/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:event_planner/models/app_user.dart';
import 'package:event_planner/services/user_services.dart';
import 'package:event_planner/widgets/password_field.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AppUser _appUser = AppUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // streambuilder is used to keep the user loged, it goes straight to the main page
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const MainPage();
          } else{
            
            return Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 20, left: 70, right: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
            
                  const Text(
                    'Log in to begin planning!', 
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 16, 34), 
                      fontSize: 25, fontWeight: 
                      FontWeight.bold),),
            
                  const SizedBox(height: 25,),

                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      label: Text("E-mail"),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),
            
                  PasswordField(
                    onPasswordChanged: (value) {
                      _appUser.password = value; // Update this line
                    },
                  ),
            
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: const Text(
                      'Forgot password?', 
                      style: TextStyle(
                        color: Color.fromARGB(255, 21, 0, 70),
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
            
                  const SizedBox(height: 25,),
            
                  ElevatedButton(
                    onPressed:() async {
                      UserServices userServices = UserServices();
                      _appUser.email = _emailController.text;
                      _appUser.password = _passwordController.text;
        
                      Future<bool> ok = userServices.signIn(
                        _appUser.email.toString(), 
                        _appUser.password.toString());
        
                      if (await ok){
                        Navigator.push(context, MaterialPageRoute(builder:(context) => const MainPage(),));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: LinearBorder.bottom()
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
            
                  const SizedBox(height: 20,),
        
                  
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Don't have an account?", style: TextStyle(color: Color.fromARGB(255, 34, 34, 34), fontWeight: FontWeight.bold,),),
            
                        const SizedBox(width: 5,),
            
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                          },
                          child: const Text('Register Now', style: TextStyle(color: Color.fromARGB(255, 6, 135, 221), fontWeight: FontWeight.bold,),),
                        ),
                    ],)
                  ),
            
            
            
            
                ],
              ),
            );
          }
        }),);
  }
}


