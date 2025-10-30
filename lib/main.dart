import 'package:flutter/material.dart';

void main() {
/* Elle nous permet de lancer l'application à travers la fonction runApp en utilisant le Widget monAppli comme Widget racine. 
 L'utilisation de const indique que les instances de monAppli sont immuables.*/
  runApp(const MonAppli());
}

/* Déclaration et initialisation de la classe monApp qui est un widget Stateless qui représente l'application elle-même. 
 Elle définit la configuration globale de l'application, notamment le titre de l'application et la page principale.*/
class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

// Déclaration d'une fonction build() qui se subtitue à la classe mère et retourne le widget MaterialApp
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Création d'un widget pour donner un titre à l'application
      title: 'Magazine', 
      // Création d'un widget pour désactiver l’affichage de la bannière de débogage dans le coin supérieur droit de l'application
      debugShowCheckedModeBanner: false, 
      // Création d'un widget pour parametrer la première page de l'application 
      home: PageAcceuil());
  }
}
/* Déclaration et initialisation de la classe qui va servir de page principale
 La classe pagePrincipale est un autre Widget Stateless qui représente la page principale de l'application. 
 Elle définit l'apparence de la page, cela comprend tous éléments visibles de l'application. */
class PageAcceuil extends StatelessWidget {
  const PageAcceuil({super.key});

// Déclaration d'une fonction build() qui se subtitue à la classe mère et retourne le widget Scaffold qui contient tous les elements visibles de la page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* Création d'un widget qui regroupe tous les proprietés de la barre horizontale haute de l'app que ce soit le titre de la page, 
      la couleur de l'arrière plan de la barre, le menu depliant et le bouton de recherche */
      appBar:  AppBar(
        // Création d'un widget pour donner une couleur à l'arrière plan du widget dont il subtitut.
        backgroundColor: Colors.pink,
        // Création d'un widget pour inserer un titre dans le widget parent. Il a une aussi propriété de position de texte avec sa position centrer et une couleur
        title: const Text('Magazine Infos',
        style: TextStyle(color : Colors.white),),
        centerTitle: true,
        // Création d'un widget pour inserer un menu deroulant qui a une icone (elle provient de package importer plus haut) et qui s'affiche quand on clique dessus.
        leading: IconButton(
          onPressed:() {},
           icon: Icon(Icons.menu, color: Colors.white),),
        // Création d'un widget pour inserer une action de recherche qui a une icone (elle provient de package importer plus haut) et qui s'active lorsqu'on clique dessus.
        actions: [
          IconButton(
            onPressed: () {},
           icon: const Icon(Icons.search, color: Colors.white),)
        ],
      ),
      // Declaration d'un widget pour l'affichage du contenu principale de l'app avec des propriétés enfants comme une image dans notre cas.
      // Le widget body regroupe tous les propriétés du corps principal de l'app
      body:const Column(
        children: [
          Image(
          image: AssetImage('assets/images/img3.jpg')),
          PartieTitre(),
          PartieTexte(),
          PartieIcone(),
          PartieRubrique(),
        ],
      ),
    );
  }
}

class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Bienvenue au Magazine Infos", style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),),
          Text("Votre Magazine numérique, votre source d'inspiration", style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),),
        ],
      ),
    );
  }
}

class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Text("Magazine Infos est bien plus qu'un magazine d'informations. C'est votre passerelle vers le monde, une source inestimable de connaissances et d'actualités soigneusement selectionnées pour vous éclairer sur les enjeux mondiaux, la culture, la science, et voir même le divertissement (le jeux).", 
      style: TextStyle(fontSize: 14.0),
      ),
    );
  }
}

class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, //// Alignement horizontal des widgets enfants (start, center, end, spaceBetween, etc.)
        children: [ Container( 
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
              const Icon(Icons.phone, color: Colors.pink),
              const SizedBox(height: 5),
              Text("Tel".toUpperCase(),
              style: const TextStyle(color: Colors.pink),)
            ],
            ),
            
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
              const Icon(Icons.mail, color: Colors.pink),
              const SizedBox(height: 5),
              Text("Tel".toUpperCase(),
              style: const TextStyle(color: Colors.pink),)
            ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
              const Icon(Icons.share, color: Colors.pink),
              const SizedBox(height: 5),
              Text("Partage".toUpperCase(),
              style: const TextStyle(color: Colors.pink),)
            ],
            ),
          ),
  ],
),
    );
  }
}

class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Image(image: AssetImage('assets/images/img4.jpg')),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Image(image: AssetImage('assets/images/img5.jpeg')),
          ),
        ],
      ),
    );
  }
}