import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../principale/Acceuil.dart';
import '../principale/code_class.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController Student = TextEditingController();
  TextEditingController ClasseId = TextEditingController();
  Map<String, dynamic> user = {};
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<void> Connexion(String studentId, String classeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/get-users?param1=$studentId&param2=$classeId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> userList = json.decode(response.body);

      if (userList.isNotEmpty) {
        setState(() {
          user = userList[0];
        });

        // Enregistrez les données dans les SharedPreferences
        final SharedPreferences sauvegarde = await SharedPreferences.getInstance();
        sauvegarde.setInt('userId', user['id']);
        sauvegarde.setString('userName', user['name']);
        sauvegarde.setString('userEmail', user['email']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Acceuil()), (route) => false);
      }
      print(response.body);
    } else {
      print('Échec de la requête');
      throw Exception('Échec de la requête');
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
              SizedBox(height: size.height/4,),
              Padding(
                padding: const EdgeInsets.only(left: 55),
                child: Row(
                  children: [
                    Text('Connexion',style: TextStyle(
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
                    controller: Student,
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
                    controller: ClasseId,
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
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 55),
                child: Row(
                  children: [
                    Text('Mot de passe oublie?'),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  Connexion(Student.text, ClasseId.text);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/1.3,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text('Se connecter',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                  ),
                ),
              ),
              SizedBox(height: size.height/4,),
              Text('Vous n\'avez pas de compte?' ),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Inscription()));
                  },
                  child: Text('S\'inscrire maintenant',style: TextStyle(
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
