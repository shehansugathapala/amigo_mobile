import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03, horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Image.asset(
                'assets/logo.png', // Assuming you have a logo image
                width: MediaQuery.of(context).size.width * 0.6,
                fit: BoxFit.contain,
              ),
            ),
            ContactDetail(
              title: 'Head Office',
              address:
              'AMIGO TRADE & INVESTMENTS (PVT) LTD\nNo 30, Kandy Road,\nDalugama, Kelaniya',
            ),
            ContactDetail(
              title: 'Main Stores',
              address: 'No. 494, Malwana, Biyagama',
            ),
            ContactDetail(
              title: 'Technical Support Centers',
              address: 'Anuradhapura\nKurunagala\nAmpara\nMahiyanganaya',
            ),
            ContactDetail(
              title: 'Customer Care',
              phone: '011 3 419 420 / 070 656 1 656',
            ),
            ContactDetail(
              title: 'Web',
              web: 'www.amigosrilanka.com',
            ),
            ContactDetail(
              title: 'Email',
              email: 'info@amigosrilanka.com',
            ),
          ],
        ),
      ),
    );
  }
}

class ContactDetail extends StatelessWidget {
  final String title;
  final String? address;
  final String? phone;
  final String? web;
  final String? email;

  const ContactDetail({
    required this.title,
    this.address,
    this.phone,
    this.web,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1, vertical: MediaQuery.of(context).size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (address != null) ...[
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(address!),
          ],
          if (phone != null) ...[
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text('Phone: $phone'),
          ],
          if (web != null) ...[
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text('Web: $web'),
          ],
          if (email != null) ...[
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text('Email: $email'),
          ],
        ],
      ),
    );
  }
}
