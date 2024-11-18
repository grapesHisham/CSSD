import 'package:flutter/material.dart';

class RequestDetailsViewCssdCussDeptUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: const Text("Request details"),
      ),
    );
  }
}
