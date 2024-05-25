import 'package:flutter/material.dart';

void main() {
  runApp(ScopeScreen());
}

class ScopeScreen extends StatelessWidget {
  final List<String> scopeDescriptions = [
    'ONSITE TECHNICAL SUPPORT',
    'WASTE WATER TREATMENT SYSTEMS',
    'DEMINERALIZATION SYSTEMS MAINTENANCE SERVICES',
    'COMMUNITY WATER PROJECTS',
    'INDUSTRIAL WATER TREATMENT SYSTEMS',
    'DRINKING WATER SYSTEMS',
    'REVERSE OSMOSIS WATER PURIFICATION SYSTEMS',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scope '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.4, // Adjusted height for mobile screens
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/scope.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Our Scope',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: scopeDescriptions.map((description) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.circle, size: 10),
                            SizedBox(width: 5),
                            Flexible(child: Text(description)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back to Main Drawer'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
