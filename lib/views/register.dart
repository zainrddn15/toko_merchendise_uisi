import 'package:flutter/material.dart';
import 'package:toko_merchandise/controller/userController.dart';
import 'package:toko_merchandise/models/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController konfirmPasswordController = TextEditingController();
  
  final UserController userController = UserController();

  bool showPwd = true;
  bool showKonfirmPwd = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPwd = true;
    showKonfirmPwd = true;
  }
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Registrasi Akun",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder()
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Please enter your email";
                          }
                          if(!value.contains("@gmail.com")){
                            return "Only gmail.com is allowed";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: namaController,
                        decoration: InputDecoration(
                          labelText: "Nama",
                          border: OutlineInputBorder()
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Please enter your name";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: showPwd,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: showPwd ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                showPwd = !showPwd;
                              });
                            },
                          )
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Please enter your password";
                          }
                          return null;
                        },
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: showKonfirmPwd,
                        controller: konfirmPasswordController,
                        decoration: InputDecoration(
                          labelText: "Konfirmasi Password",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                showKonfirmPwd = !showKonfirmPwd;
                              });
                            }, 
                            icon: showKonfirmPwd ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                          )
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Please enter your confirm password";
                          }
                          if(value != passwordController.text){
                            return "Password does not match";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate())
                        {
                         userController.registerUser(
                            User(id: 0, 
                            nama: namaController.text, 
                            email: emailController.text, 
                            password: passwordController.text
                            )
                         ).then((message){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message))
                            );

                            Navigator.pop(context);
                         });
                        }
                      }, 
                      child: Text("Simpan")
                    )
                  ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}