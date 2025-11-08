import 'package:flutter/material.dart';
import 'package:activite1/modele/redacteur.dart';
import 'package:activite1/database/database_manager.dart';

/// Widget principal de l'application (StatelessWidget)
/// Il ne change jamais, il sert juste à configurer l'app
class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:  AppBar(
        // Création d'un widget pour donner une couleur à l'arrière plan du widget dont il subtitut.
          backgroundColor: Colors.pink,
        // Création d'un widget pour inserer un titre dans le widget parent. Il a une aussi propriété de position de texte avec sa position centrer et une couleur
          title: const Text('Gestion des Redacteurs',
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
        body: RedacteurInterface(),


      ),
    );
  }
}

// Interface principale de gestion des rédacteurs (StatefulWidget)
/// StatefulWidget car l'interface change quand on ajoute/modifie/supprime des rédacteurs
class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});

  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

/// État de l'interface RedacteurInterface
/// C'est ici que se trouve toute la logique de l'interface
class _RedacteurInterfaceState extends State<RedacteurInterface> {

  // Instance du gestionnaire de base de données
  final DatabaseManager _dbManager = DatabaseManager();

   // Liste des rédacteurs affichés à l'écran
  List<Redacteur> _redacteurs = [];

  // Contrôleurs pour les champs de texte
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

   /// Méthode appelée automatiquement quand le widget est créé
  /// C'est ici qu'on charge les données initiales
  @override
  void initState() {
    super.initState();
    _chargerRedacteurs(); // Charger la liste des rédacteurs au démarrage
  }

  /// Méthode pour charger tous les rédacteurs depuis la base de données
  Future<void> _chargerRedacteurs() async {
    List<Redacteur> redacteurs = await _dbManager.getAllRedacteurs();
    setState(() {
      _redacteurs = redacteurs; // Met à jour l'interface avec les nouvelles données
    });
  }

  /// Méthode pour ajouter un nouveau rédacteur
  Future<void> _ajouterRedacteur() async {
    // Vérifier que les champs ne sont pas vides
    if (_nomController.text.isEmpty || 
        _prenomController.text.isEmpty || 
        _emailController.text.isEmpty) {
      _afficherMessage('Veuillez remplir tous les champs');
      return;
    }

    // Créer un nouvel objet Redacteur
    Redacteur nouveauRedacteur = Redacteur.sansId(
      nom: _nomController.text,
      prenom: _prenomController.text,
      email: _emailController.text,
    );

    // Insérer dans la base de données
    await _dbManager.insertRedacteur(nouveauRedacteur);

    // Vider les champs de texte
    _nomController.clear();
    _prenomController.clear();
    _emailController.clear();

    // Recharger la liste
    await _chargerRedacteurs();

    // Afficher un message de succès
    _afficherMessage('Rédacteur ajouté avec succès');
  }

  /// Méthode pour afficher la boîte de dialogue de modification
  Future<void> _afficherDialogueModification(Redacteur redacteur) async {
    // Contrôleurs pré-remplis avec les données actuelles
    final TextEditingController nomModifController = 
        TextEditingController(text: redacteur.nom);
    final TextEditingController prenomModifController = 
        TextEditingController(text: redacteur.prenom);
    final TextEditingController emailModifController = 
        TextEditingController(text: redacteur.email);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modifier le rédacteur'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomModifController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: prenomModifController,
                  decoration: const InputDecoration(labelText: 'Prénom'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailModifController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Créer un rédacteur modifié avec le même id
                Redacteur redacteurModifie = Redacteur(
                  id: redacteur.id,
                  nom: nomModifController.text,
                  prenom: prenomModifController.text,
                  email: emailModifController.text,
                );

                // Mettre à jour dans la base de données
                await _dbManager.updateRedacteur(redacteurModifie);

                // Fermer la boîte de dialogue
                Navigator.of(context).pop();

                // Recharger la liste
                await _chargerRedacteurs();

                // Afficher un message
                _afficherMessage('Rédacteur modifié avec succès');
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  /// Méthode pour afficher la boîte de dialogue de confirmation de suppression
  Future<void> _afficherDialogueSuppression(Redacteur redacteur) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: Text(
            'Êtes-vous sûr de vouloir supprimer ${redacteur.prenom} ${redacteur.nom} ?'
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Supprimer de la base de données
                await _dbManager.deleteRedacteur(redacteur.id!);

                // Fermer la boîte de dialogue
                Navigator.of(context).pop();

                // Recharger la liste
                await _chargerRedacteurs();

                // Afficher un message
                _afficherMessage('Rédacteur supprimé');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  /// Méthode pour afficher un message temporaire (SnackBar)
  void _afficherMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Libérer les ressources quand le widget est détruit
  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
      children: [
        TextField(
          controller: _nomController,
          cursorColor: Colors.pink,
          decoration: const InputDecoration(
            labelText: "Nom",
            floatingLabelStyle: TextStyle(
              color: Colors.pink),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.pink)
            ),),

        ),
        TextField(
          controller: _prenomController,
          cursorColor: Colors.pink,
          decoration: const InputDecoration(
            labelText: "Prenom",
            floatingLabelStyle: TextStyle(
              color: Colors.pink),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.pink)
            ),),
        ),
        TextField(
          controller: _emailController,
          cursorColor: Colors.pink,
          decoration: const InputDecoration(
            labelText: "Email",
            floatingLabelStyle: TextStyle(
              color: Colors.pink),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.pink)
            ),),
          
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), 
                ),
                elevation: 75.0,
              ),
              icon: const Icon(Icons.add),
              label: const Text("Ajouter un Rédacteur"),
              onPressed: _ajouterRedacteur,    
          ),
          ),
           const SizedBox(
            height: 20
          ),
          // ===== SECTION LISTE DES RÉDACTEURS =====
            const Text(
              'Liste des Rédacteurs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10),
            // Liste scrollable des rédacteurs
            Expanded(
              child: _redacteurs.isEmpty
                  ? const Center(
                      child: Text(
                        'Aucun rédacteur enregistré',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
              : ListView.builder(
                      itemCount: _redacteurs.length,
                      itemBuilder: (context, index) {
                        final redacteur = _redacteurs[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                redacteur.prenom[0].toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              '${redacteur.prenom} ${redacteur.nom}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(redacteur.email),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Bouton Modifier
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.orange),
                                  onPressed: () => _afficherDialogueModification(redacteur),
                                ),
                                // Bouton Supprimer
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _afficherDialogueSuppression(redacteur),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
        );
  }
}