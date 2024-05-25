
import 'package:amigo_mobile/screens/scopescreen.dart';
import 'package:amigo_mobile/screens/services_screen.dart';
import 'package:flutter/material.dart';

import 'contact.dart';
import 'customer_profile.dart';


class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Text(
              'AMIGO',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () {
              // Assuming isAdmin is a variable indicating whether the user is an admin
              bool isAdmin = true; // Set this based on your logic to determine user type
              if (isAdmin) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>CustomerProfileScreen(),// Navigate to
                  ),
                );
              } else {
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.design_services),
            title: Text('Services'),
            onTap: () {
              // Assuming isAdmin is a variable indicating whether the user is an admin
              bool isAdmin = true;// Set this based on your logic to determine user type
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>ServicesScreen(),// Navigate to AdminChatScreen
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people_sharp),
            title: Text('Our Scope'),
            onTap: () {
              // Handle navigation to Customer Inquiries screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScopeScreen(),// Navigate to AdminChatScreen
                ),
              );// Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.label_important),
            title: Text('Contact us'),
            onTap: () {
              // Handle navigation to Complaints screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactScreen(),// Navigate to AdminChatScreen
                ),
              ); // Close the drawer
            },
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              // Handle logging out
              // You can implement your logout logic here
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
