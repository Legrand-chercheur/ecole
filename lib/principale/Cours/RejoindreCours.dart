import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Acceuil.dart';

class Rejoindre extends StatefulWidget {
  const Rejoindre({Key? key}) : super(key: key);

  @override
  State<Rejoindre> createState() => _RejoindreState();
}

String? userName = '';
String? userEmail = '';
int? userId = 0;

class _RejoindreState extends State<Rejoindre> {
  TextEditingController codeController = TextEditingController();
  bool isCodeValid = false;

  void session() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
      userEmail = prefs.getString('userEmail');
      userId = prefs.getInt('userId');

    });
  }

  Future<void> checkCourseCode(String codeCours) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/check-course-code?code_cours=$codeCours'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['exists']) {
        // Le code de cours existe, vous pouvez procéder à l'enregistrement
        await registerParticipant(codeCours,userId!);
      } else {
        // Le code de cours n'existe pas, affichez un message d'erreur à l'utilisateur
      }
    } else {
      // Gérez les erreurs de requête
    }
  }

  Future<void> registerParticipant(String codeCours, int userId) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/register-participant'),
      body: {
        'code_cours': codeCours,
        'user_id': userId.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Participant enregistré avec succès
      // Affichez un message ou effectuez d'autres actions nécessaires
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Acceuil()), (route) => false);
    } else {
      // Gérez les erreurs de requête
    }
  }


  @override
  void initState() {
    super.initState();
    session();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Rejoindre...'),
            GestureDetector(
              onTap: isCodeValid
                  ? () {
                // Action à effectuer lorsqu'on clique sur "Rejoindre le cours"
                checkCourseCode(codeController.text);
              }
                  : null,
              child: Container(
                width: size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                  color: isCodeValid ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Rejoindre le cours',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Center(
            child: Text(
              'Mr/Mme vous êtes actuellement connecté(e) au compte',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 20,),
                        Text(
                          userName!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          userEmail!,
                          style: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child:
            Text('Demandez le code du cours à votre enseignant, puis saisissez-le ici.'),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isCodeValid ? Colors.blueAccent : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: codeController,
                  onChanged: (text) {
                    setState(() {
                      isCodeValid = text.length == 6;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Code du cours',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              '', // Mettez ici le texte souhaité
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

