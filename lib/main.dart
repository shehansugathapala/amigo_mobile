import 'package:amigo_mobile/provider/user_provider.dart';
import 'package:amigo_mobile/screens/admin_chat.dart';
import 'package:amigo_mobile/screens/admindrawer.dart';
import 'package:amigo_mobile/screens/customer_profile.dart';
import 'package:amigo_mobile/screens/drawer_screen.dart';
import 'package:amigo_mobile/service/auth_services.dart';
import 'package:amigo_mobile/screens/signup_screen.dart';
import 'package:amigo_mobile/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    AuthService fetchUserDetails; (context);
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return MaterialApp(
      title: 'Flutter Node Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: userProvider.user.token.isEmpty ? '/signup' : userProvider.user.isAdmin ? '/admin' : '/chat',
      routes: {
        '/signup': (context) => const SignupScreen(),
        '/admin': (context) => AdminDrawer(title: 'drawer'),
        '/chat': (context) => MainDrawer(title: 'drawer'),
      },// Navigate to chat screen for normal user
    );
  }
}
