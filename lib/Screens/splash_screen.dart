import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_and_functions/Screens/admin_screen.dart';
import 'package:splash_and_functions/Screens/home_screen.dart';
import 'package:splash_and_functions/Screens/student_screen.dart';
import 'package:splash_and_functions/Screens/teacher_screen.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    isLogIn();
  }
  Future<void> isLogIn () async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogIn = sp.getBool('isLogIn')?? false;
    String userType = sp.getString('type') ?? '';

    if (isLogIn) {

      if(userType == 'student') {
        Timer(const Duration(seconds: 5), () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StudentScreen())
          );
        });
      }else if (userType == 'Teacher'){
        Timer(const Duration(seconds: 5), () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TeacherScreen())
          );
        });
      }else if(userType == 'Admin'){
        Timer(const Duration(seconds: 5), () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminScreen())
          );
        });
      }
      else {
        Timer(const Duration(seconds: 5), () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen())
          );
        });
      }

    }else{
      Timer(const Duration(seconds: 5), () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen())
        );
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Image(
        height: double.infinity,
          fit: BoxFit.fitHeight,
          image: NetworkImage('https://images.pexels.com/photos/16861541/pexels-photo-16861541/free-photo-of-arbres.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')),
    );
  }
}
