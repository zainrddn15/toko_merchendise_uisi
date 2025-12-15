import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_merchandise/controller/userController.dart';
import 'package:toko_merchandise/models/user.dart';
import 'package:toko_merchandise/views/barang.dart';
import 'package:toko_merchandise/views/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 

  String nama = "";
  String email = "";
  UserController userController = UserController();

  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
    init();

    
  }

  init() async {
     final pref = await SharedPreferences.getInstance();
     print("nama: ${pref.getString("nama")}");

      setState(() {
        nama = pref.getString("nama") ?? "";
        email = pref.getString("email") ?? "";
      });
     
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selamat datang, $nama"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(nama), accountEmail: Text(email)
            ),
            ListTile(
              title: Text("Data Barang"),
              onTap: () {
                Navigator.push(context, 
                    MaterialPageRoute(builder: (BuildContext context) => HalamanBarang())
                  );
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () async  {
                await userController.logout();

                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (BuildContext context) => LoginScreen())
                );

              },

            )
          ],
        ),
      ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Selamat datang, $nama"),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  
                }, 
                child: Text("Lihat Data Barang"),
              )
            ],
          ),
        ),
      );
  }
}