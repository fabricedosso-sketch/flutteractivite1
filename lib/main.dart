import 'package:flutter/material.dart';
import 'package:activite1/pages/redacteur_interface.dart';

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
      // ici la page d'acceuil fait appel à la page de la gestion des redacteurs qui est dans un fichier different du main.
      home: MonApplication());
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
      // Declaration d'un widget pour l'affichage du contenu principale de l'app avec des propriétés enfants comme une image dans notre cas et les autres blocs de notre page d'acceuil.
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

/* Déclaration et initialisation de la classe qui va nous permettre de créer le seconde bloc de la page
 La classe PartieTitre est un autre Widget Stateless qui représente un bloc de type conteneur. 
 Elle définit un conteneur contenant un element enfant de type colonne qui englobe aussi deux elements enfanst de type texte. */
class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // Creation d'une marge interieur de tous les côtés de l'element
      padding: const EdgeInsets.all(20),
      // Création d'un element enfant de type colonne avec un alignement horizontalement 
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Création de deux éléments enfants de type texte avec une propriété style appliquant une taille et une mise en forme de police.
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

/* Déclaration et initialisation de la classe qui va nous permettre de créer le troisième bloc de la page
 La classe PartieTexte est un autre Widget Stateless qui représente un bloc de type conteneur. 
 Elle définit un conteneur contenant un element enfant de type texte avec une propriété style appliquant une taille de police. */
class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Ajout d'une marge interieur des côtés horizontaux seulement.
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // Création d'un element enfant de type texte avec une propriété style appliquant une taille de police.
      child: const Text("Magazine Infos est bien plus qu'un magazine d'informations. C'est votre passerelle vers le monde, une source inestimable de connaissances et d'actualités soigneusement selectionnées pour vous éclairer sur les enjeux mondiaux, la culture, la science, et voir même le divertissement (le jeux).", 
      style: TextStyle(fontSize: 14.0),
      ),
    );
  }
}

/* Déclaration et initialisation de la classe qui va nous permettre de créer le quatrième bloc de la page
 La classe PartieIcone est un autre Widget Stateless qui représente un bloc de type conteneur. 
 Elle définit un conteneur contenant un element enfant de type ligne qui englobe aussi trois elements enfants de type conteneur
  qui eux à leur tour contiennent chacun un element enfant. Chaque element enfant contient lui aussi des elements enfants qui sonht de type icone, texte et box avec leur propriétés distinctes. */
class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      // Ajout d'une ligne dans son widget parent
      child: Row( 
        // Alignement horizontal des widgets enfants
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        // Ajout de trois bloc de conteneur dans son widget parent
        children: [ Container( 
            // Ajout d'une marge intérieure de 20 pixel de tous les côtés au premier widget enfant 
            padding: const EdgeInsets.all(20),
            // Ajout d'une colonne qui est le widget enfant du widget parent qui est le premier conteneur
            child: Column(
              // Création de trois bloc de conteneur dans le widget parent
              children: [
              // Ajout d'une icone de téléphone avec une couleur rose
              const Icon(Icons.phone, color: Colors.pink),
              // Ajout d'un box d'une taille de 5 pixels
              const SizedBox(height: 5),
              // Ajout d'un texte tout en majuscule avec une couleur rose
              Text("Tel".toUpperCase(),
              style: const TextStyle(color: Colors.pink),)
            ],
            ),
            
          ),
          Container(
            // Ajout d'une marge intérieure de 20 pixel de tous les côtés au deuxième widget enfant 
            padding: const EdgeInsets.all(20),
            // Ajout d'une colonne qui est le widget enfant du widget parent qui est le deuxième conteneur
            child: Column(
              // Création de trois bloc de conteneur dans le widget parent
              children: [
              // Ajout d'une icone d'email avec une couleur rose
              const Icon(Icons.mail, color: Colors.pink),
              // Ajout d'un box d'une taille de 5 pixels
              const SizedBox(height: 5),
              // Ajout d'un texte tout en majuscule avec une couleur rose
              Text("Tel".toUpperCase(),
              style: const TextStyle(color: Colors.pink),)
            ],
            ),
          ),
          Container(
            // Ajout d'une marge intérieure de 20 pixel de tous les côtés au troisième widget enfant 
            padding: const EdgeInsets.all(20),
            // Ajout d'une colonne qui est le widget enfant du widget parent qui est le troisième conteneur
            child: Column(
              // Ajout de trois bloc de conteneur dans le widget parent
              children: [
              // Ajout d'une icone de partage avec une couleur rose  
              const Icon(Icons.share, color: Colors.pink),
              // Ajout d'un box d'une taille de 5 pixels
              const SizedBox(height: 5),
              // Ajout d'un texte tout en majuscule avec une couleur rose
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

/* Déclaration et initialisation de la classe qui va nous permettre de créer le troisième bloc de la page
 La classe PartieRubrique est un autre Widget Stateless qui représente un bloc de type conteneur. 
 Elle définit un conteneur contenant un element enfant de type ligne qui englobe deux elements enfants de type d'arrondi de cadre qui eux à leur tour contiennent chacun enfant de type image. */
class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Ajout d'une marge interieur des côtés horizontaux seulement.
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // Ajout d'une ligne dans son widget parent
      child: Row(
        // Alignement horizontal des widgets enfants
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // Ajout de deux cadres rectangulaire aux côtés arrondis dans le widget parent
        children: [
          // Ajout d'un cadre rectangulaire aux côtés arrondis dans le widget parent
          ClipRRect(
            // Ajout d'une bordure circulaire de 8 pixels aux extremités du cadre rectangulaire
            borderRadius: BorderRadius.circular(8),
            // Ajout d'une image dans le cadre comme widget enfant
            child: const Image(
              image: AssetImage('assets/images/img4.jpeg')),
          ),
          // Ajout d'un cadre rectangulaire aux côtés arrondis dans le widget parent
          ClipRRect(
            // Ajout d'une bordure circulaire de 8 pixels aux extremités du cadre rectangulaire
            borderRadius: BorderRadius.circular(8),
            // Ajout d'une image dans le cadre comme widget enfant
            child: const Image(
              image: AssetImage('assets/images/img5.jpeg')),
          ),
        ],
      ),
    );
  }
}
