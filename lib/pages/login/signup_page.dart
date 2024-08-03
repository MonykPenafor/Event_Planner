import 'package:event_planner/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:event_planner/services/user_services.dart';
import 'package:event_planner/widgets/password_field.dart';
import 'package:provider/provider.dart';
import '../../components/custom_snackbar.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  final AppUser _appUser = AppUser();

@override
Widget build(BuildContext context) {

  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(30),
      child: Consumer<UserServices>(
        builder: (context, userServices, child) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('SIGN UP', 
              style: TextStyle(
                color:  Color.fromARGB(255, 41, 41, 41), fontSize: 20, fontWeight: FontWeight.bold),),
              
              const SizedBox(height: 15,),

              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  label: Text("Username"),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.7))
                ),
              ),

              const SizedBox(height: 10,),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  label: Text("E-mail"),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.2)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1.7))
                ),
              ),

              const SizedBox(height: 10,),

              PasswordField(
                onPasswordChanged: (value) {
                  _passwordController.text = value;
                },
              ),

              Column(
                children: [
                  const SizedBox(height: 30,),

                  ElevatedButton(
                    onPressed: () async {
                      _appUser.userName = _userNameController.text;
                      _appUser.email = _emailController.text;
                      _appUser.password = _passwordController.text;

                      var result = await userServices.signUp(
                        _appUser.userName.toString(), 
                        _appUser.email.toString(), 
                        _appUser.password.toString()
                      );

                      CustomSnackBar.show(context, result['message'], result['success']);

                      if (result['success']) {
                        Navigator.pop(context);
                      } 
                    },

                    style: ElevatedButton.styleFrom(
                      elevation: 1.5,
                      minimumSize: const Size.fromHeight(50),
                      shape: LinearBorder.bottom()
                    ),

                    child: const Text( 'Register',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25,),

              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    const Text('Already have an account?', 
                      style: TextStyle(
                        color: Color.fromARGB(255, 34, 34, 34), 
                        fontWeight: FontWeight.
                        bold,),),

                    const SizedBox(width: 5,),

                    InkWell(
                      onTap: () {Navigator.pushNamed(context, '/login');},
                      child: const Text('Login', 
                        style: TextStyle(
                          color: Color.fromARGB(255, 6, 135, 221), 
                          fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

}
