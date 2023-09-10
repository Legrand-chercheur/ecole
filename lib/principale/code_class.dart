import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CodeClass extends StatefulWidget {
  const CodeClass({super.key});

  @override
  State<CodeClass> createState() => _CodeClassState();
}
String? userName = '';
String? userEmail = '';
class _CodeClassState extends State<CodeClass> {

  void session()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
      userEmail = prefs.getString('userEmail');
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    session();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nom: $userName'),
            Text('Email: $userEmail'),
          ],
        ),
      ),
    );
  }
}





