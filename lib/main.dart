import 'package:flutter/material.dart';
import 'package:toko_merchandise/controller/userController.dart';
import 'package:toko_merchandise/views/home.dart';
import 'package:toko_merchandise/views/login.dart';

void main() {
  runApp(MainApp());
  
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: session()
    );
  }

  Widget session(){
    return FutureBuilder<bool>(
      future: UserController().checkSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data == true) {
          print("check session: ${snapshot.data}");
          return HomeScreen();
        }
        return LoginScreen();
      },
    );
  }
}
