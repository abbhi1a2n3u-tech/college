import 'package:flutter/material.dart';
import 'package:untitled/Screen/widgets/class_wdigets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ClassesPoster(title: "Hello", subtitle: "subtitle", imageUrl: "https://th.bing.com/th/id/OIP.8PNc5XkDdbWAagUPZpNIuwAAAA?w=261&h=181&c=7&r=0&o=7&pid=1.7&rm=3"),
      ),
    );
  }
}