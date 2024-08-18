import 'package:event_planner/pages/home/main_navigation_page.dart';
import 'package:event_planner/components/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:event_planner/services/user_services.dart';
import 'package:event_planner/components/password_field.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return const MainNavigationPage();
          } 
          else {
            return Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 20, left: 70, right: 70),
              child: Consumer<UserServices>(
                builder: (context, userServices, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Text( 'LOG IN',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 16, 34),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),

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
                          _passwordController.text = value;
                        },
                      ),

                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(top: 8.0),
                        child: const Text( 'Forgot password?',
                          style: TextStyle(
                              color: Color.fromARGB(255, 21, 0, 70),
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),

                      const SizedBox(height: 25,),

                      ElevatedButton(
                        onPressed: () async {

                          var result = await userServices.signIn(
                            _emailController.text,
                            _passwordController.text,
                          );

                          CustomSnackBar.show(context, result['message'], result['success']);

                          if (result['success']) {
                            await Future.delayed(const Duration(seconds: 1));
                            Navigator.pushReplacementNamed(context, '/mainNav');
                          } 
                        },

                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: LinearBorder.bottom()
                        ),

                        child: const Text('Login',
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

                            const Text( "Don't have an account?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 34, 34, 34),
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 5,),

                            InkWell(
                              onTap: () { Navigator.pushNamed(context, '/signup');},
                              child: const Text( 'Register',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 6, 135, 221),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}