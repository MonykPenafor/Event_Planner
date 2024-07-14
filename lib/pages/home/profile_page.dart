import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/user_services.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final String profileImageUrl = 'https://example.com/profile.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Consumer<UserServices>(
                  builder: (context, userServices, child) {
                    if (userServices.appUser == null) {
                      return const CircularProgressIndicator();
                    } else {
                      return Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(profileImageUrl),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                userServices.appUser!.userName!,
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                userServices.appUser!.id!,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                userServices.appUser!.email!,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
