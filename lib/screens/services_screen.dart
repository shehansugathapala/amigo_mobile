import 'package:flutter/material.dart';

void main() {
  runApp(ServicesScreen());
}

class ServicesScreen extends StatelessWidget {
  final List<String> services = [
    'FILTER MEDIA REPLACEMENTS',
    'ONSITE TECHNICAL SUPPORT',
    'PREVENTIVE & CORRECTIVE MAINTENANCE SERVICES',
  ];

  // Mapping services to their respective images
  final Map<String, String> serviceImages = {
    'FILTER MEDIA REPLACEMENTS': 'assets/filtermedia.jpg',
    'ONSITE TECHNICAL SUPPORT': 'assets/onsite.jpg',
    'PREVENTIVE & CORRECTIVE MAINTENANCE SERVICES': 'assets/preventive.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Our Services'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: services.map((service) {
              return ServiceCard(
                service: service,
                image: serviceImages[service]!,
              );
            }).toList(),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Back to Main Drawer'),
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String service;
  final String image;

  ServiceCard({required this.service, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8, // Adjusted width for mobile screens
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              service,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
