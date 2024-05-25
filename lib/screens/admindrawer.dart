import 'package:flutter/material.dart';
import 'admin_chat.dart'; // Import the appropriate file for AdminChatScreen
import 'customer_profile.dart'; // Import the appropriate file for CustomerProfileScreen

class  AdminDrawer extends StatelessWidget {
  const  AdminDrawer({Key? key, required this.title}) : super(key: key);

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
                    builder: (context) => AdminChatScreen(), // Navigate to AdminChatScreen
                  ),
                );
              } else {
              }
            },
          ),

          ListTile(
            leading: Icon(Icons.people_sharp),
            title: Text('Customer Inquiries'),
            onTap: () {
              // Handle navigation to Customer Inquiries screen
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.label_important),
            title: Text('Complaints'),
            onTap: () {
              // Handle navigation to Complaints screen
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
            onTap: () {
              // Handle navigation to Edit Profile screen
              Navigator.pop(context); // Close the drawer
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
