import 'package:ecole/principale/Cours/RejoindreCours.dart';
import 'package:flutter/material.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 80,
                width: size.height,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 15,),
                        Icon(Icons.menu,color: Colors.white,),
                        SizedBox(width: 15,),
                        Text('EducPro',style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                            height: 40,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person,color: Colors.blueAccent,),
                            )
                        ),
                        SizedBox(width: 25,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height/2.2,),
              Text('Participez a ou creez un cours ci dessous')
            ],
          ),
          Positioned(
            left: size.width/1.3,
            top: size.height/1.14,
            child: Container(
                width: 70,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 140, // Augmentez la hauteur selon vos besoins
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              ListTile(
                                title: Text('Créer un cours'),
                                onTap: () {
                                  // Action à effectuer lorsqu'on clique sur "Créer un cours"
                                  Navigator.pop(context); // Fermer le modal
                                  // Ajoutez le code pour créer un cours ici
                                },
                              ),
                              ListTile(
                                title: Text('Rejoindre un cours'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Rejoindre()));
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );

                  },
                  child: Icon(Icons.add,color: Colors.white,),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: Colors.blueAccent,
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }
}
