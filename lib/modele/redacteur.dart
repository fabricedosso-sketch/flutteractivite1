// lib/modele/redacteur.dart

/// Classe qui représente un rédacteur dans notre application
/// C'est le MODÈLE de données qui définit la structure d'un rédacteur
class Redacteur {
  // Attributs de la classe
  int? id;          // Clé primaire (peut être null avant insertion en BD)
  String nom;       // Nom du rédacteur
  String prenom;    // Prénom du rédacteur
  String email;     // Email du rédacteur

  /// Constructeur avec tous les attributs
  /// Utilisé quand on récupère un rédacteur depuis la base de données
  Redacteur({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  /// Constructeur sans l'id
  /// Utilisé quand on crée un nouveau rédacteur (l'id sera généré automatiquement)
  Redacteur.sansId({
    required this.nom,
    required this.prenom,
    required this.email,
  });

  /// Méthode qui convertit un objet Redacteur en Map
  /// Utile pour insérer/mettre à jour dans la base de données SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
    };
  }

  /// Factory constructor qui crée un Redacteur à partir d'un Map
  /// Utile pour convertir les résultats de requêtes SQL en objets Redacteur
  factory Redacteur.fromMap(Map<String, dynamic> map) {
    return Redacteur(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
    );
  }

  /// Méthode toString pour faciliter le débogage
  /// Affiche les informations du rédacteur de manière lisible
  @override
  String toString() {
    return 'Redacteur{id: $id, nom: $nom, prenom: $prenom, email: $email}';
  }
}