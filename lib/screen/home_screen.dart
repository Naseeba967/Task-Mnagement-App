import 'package:developer_hub_authentication_app/screen/login_screen.dart';
import 'package:developer_hub_authentication_app/services/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authFirebaseService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    final currentUser = _authFirebaseService.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () async {
              await _authFirebaseService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Welcome!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            textAlign: TextAlign.center,
            currentUser?.displayName ?? 'User',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 8),
          Text(
            textAlign: TextAlign.center,
            currentUser?.email ?? '',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
