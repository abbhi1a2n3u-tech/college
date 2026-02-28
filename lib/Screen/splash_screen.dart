import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Screen/login_screen.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checklogin();
  }

  Future<void> checklogin() async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      /// ⭐ token nahi mila → direct login
      if (token == null || token.isEmpty) {
        goLogin();
        return;
      }

      final res = await http.get(
        Uri.parse("https://miscreated-forcibly-javon.ngrok-free.dev/api/verifyToken"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (!mounted) return;

      if (res.statusCode == 200) {
        goHome();
      } else {
        await prefs.remove("token");
        goLogin();
      }
    } catch (e) {
      goLogin();
    }
  }

  void goHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void goLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.flutter_dash, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "My App",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}