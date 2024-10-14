import 'package:flutter/material.dart';
import 'header_bar.dart'; // Import your header bar
import 'footer_bar.dart'; // Import your footer bar

class BaseScreen extends StatelessWidget {
  final Widget child;

  final String title;

  // BaseScreen({required this.child});

  BaseScreen({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF50C9C3), // Light gradient color
              Color(0xFF96DEDA), // Dark gradient color
            ],
          ),
        ),
        child: Column(
          children: [
            HeaderBar(
              title: title,
              isBackButtonVisible: false,
            ), // Custom header widget
            Expanded(child: child), // Place the content of the screen
            FooterBar(), // Custom footer widget
          ],
        ),
      ),
    );
  }
}
