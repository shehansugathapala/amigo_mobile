import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../service/auth_services.dart';
import '../widgets/text.dart';
import 'chat_screen.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({Key? key}) : super(key: key);

  @override
  _CustomerProfileScreenState createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  AuthService authService = AuthService(); // Initialize AuthService

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Call function to fetch user data when the screen initializes
  }

  Future<void> _fetchUserData() async {
    String? authToken = await authService.getAuthToken();
    String? userEmail = await authService.getUserEmail();
    bool? userIsAdmin = await authService.isAdmin();

    // Set the retrieved username to the state
    setState(() {
      _username = userEmail;
      _isAdmin = userIsAdmin;
    });
  }

  String? _username; // Variable to store the retrieved username
  bool? _isAdmin; // Variable to store isAdmin status

  // Function to handle file upload
  Future<void> _uploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        String apiUrl = 'http://${Constants.serverIP}/api/upload'; // Replace with your server URL


        var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
        var response = await request.send();

        if (response.statusCode == 200) {
          print('File uploaded successfully');
          // Show a Snackbar message when file upload is successful
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File uploaded successfully'),
              duration: Duration(seconds: 3), // Adjust duration as needed
            ),
          );
        } else {
          print('Failed to upload file. Error: ${response.reasonPhrase}');
          // Handle error
        }
      } else {
        // User canceled file picking
        print('User canceled file picking');
      }
    } catch (e) {
      print('Error uploading file: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userData = userProvider.user; // Use user instead of userData

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue, // You can change the color as needed
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            if (_username != null && _isAdmin != null) // Check if data is retrieved
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Username: $_username!',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      TextWidget(
                        text: 'Is Admin: ${_isAdmin! ? 'Yes' : 'No'}', // Use retrieved isAdmin status
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 60),

                      ElevatedButton(
                        onPressed: _uploadFile, // Call function to upload file
                        child: Text('Upload File'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatScreen()),
                          );
                        },
                        child: Text(
                          'Chat with Amigo',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (_username == null || _isAdmin == null) // Handle the case where data is not retrieved
              CircularProgressIndicator(), // or show a different widget
          ],
        ),
      ),
    );
  }
}
