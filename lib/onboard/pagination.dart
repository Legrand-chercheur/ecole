class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Compte Etudiant',
      image: 'image/etudiant.json',
      discription: "Creer votre compte etudiant pour avoir acces a la platforme"
  ),
  UnbordingContent(
      title: 'EdocPro classroom',
      image: 'image/classe.json',
      discription: "Grace a un code EduClasse assistez et ne ratez aucun cours de la classe dans laquelle vous etes"
  ),
  UnbordingContent(
      title: 'MyEduClasse',
      image: 'assets/bus.json',
      discription: "Vous pouvez aussi creer une classe pour lancer vos activites"
  ),
];
