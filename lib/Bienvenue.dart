import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'login_register/login.dart';
import 'onboard/onboarding.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 280,
              height: 280,
              child: Lottie.asset('image/ecole.json'),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: Column(
              children: [
                Text('Bienvenue sur EducPro',style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),),
                Text('Bienvenue sur EducPro qui est une application qui fait dans le suivi scolaire',style: TextStyle(
                    fontSize: 15
                ),),
              ],
            ),
          ),
          SizedBox(height: size.height/8,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Defile()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 25,right: 25),
              child: Container(
                width: size.height/1.5,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueAccent
                ),
                child: Center(
                  child: Text('Commencer',style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 25,right: 25),
              child: Container(
                width: size.height/2,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green
                ),
                child: Center(
                  child: Text('Se connecter',style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
