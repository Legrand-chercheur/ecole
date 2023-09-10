import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerUser() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/register'),
      body: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // L'inscription a réussi, vous pouvez afficher un message à l'utilisateur
      // ou naviguer vers une autre page.
      print('c\'est top');
    } else {
      throw Exception('Échec de l\'inscription');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height/5,),
              Padding(
                padding: const EdgeInsets.only(left: 55),
                child: Row(
                  children: [
                    Text('Inscription',style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width/1.3,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      icon: Icon(CupertinoIcons.person_alt,color: Colors.white,),
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      hintText: "Nom & Prenom",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),

                      focusColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,

                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width/1.3,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.black26,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      icon: Icon(CupertinoIcons.mail_solid,color: Colors.white,),
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),

                      focusColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,

                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width/1.3,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(CupertinoIcons.lock_fill,color: Colors.white,),
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      hintText: "Mot de passe",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),

                      focusColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,

                    ),
                  ),
                ),
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  registerUser();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/1.3,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text('S\'inscrire',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                  ),
                ),
              ),
              SizedBox(height: size.height/4,),
              Text('Vous avez deja un compte?' ),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  },
                  child: Text('Se connecter maintenant',style: TextStyle(
                      color: Colors.blueAccent
                  ),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
