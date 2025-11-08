import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:activite1/modele/redacteur.dart';

/// Classe qui gère toutes les opérations sur la base de données SQLite
/// C'est le CONTRÔLEUR qui fait le lien entre notre app et la base de données
class DatabaseManager {
  // Instance unique de la base de données (pattern Singleton)
  static Database? _database;

  /// Getter qui retourne la base de données
  /// Si elle n'existe pas encore, elle est créée
  Future<Database> get database async {
    // Si la base existe déjà, on la retourne
    if (_database != null) return _database!;

    // Sinon, on l'initialise
    _database = await _initDatabase();
    return _database!;
  }

  /// Méthode privée qui initialise la base de données
  /// Elle est appelée une seule fois au premier accès
  Future<Database> _initDatabase() async {
    // Obtenir le chemin du dossier des bases de données sur l'appareil
    String databasesPath = await getDatabasesPath();
    
    // Créer le chemin complet vers notre fichier de base de données
    String path = join(databasesPath, 'redacteurs.db');

    // Ouvrir/créer la base de données
    return await openDatabase(
      path,
      version: 1, // Version de la base (utile pour les migrations futures)
      onCreate: _onCreate, // Fonction appelée lors de la première création
    );
  }

  /// Méthode appelée lors de la création de la base de données
  /// Elle crée la table 'redacteurs' avec sa structure
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE redacteurs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        prenom TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
    
    print('Table redacteurs créée avec succès');
  }

  /// Récupère TOUS les rédacteurs de la base de données
  /// Retourne une liste d'objets Redacteur
  Future<List<Redacteur>> getAllRedacteurs() async {
    // Obtenir l'instance de la base de données
    final db = await database;

    // Exécuter une requête SELECT pour récupérer tous les enregistrements
    // Résultat : List<Map<String, dynamic>>
    final List<Map<String, dynamic>> maps = await db.query('redacteurs');

    // Convertir chaque Map en objet Redacteur
    return List.generate(maps.length, (i) {
      return Redacteur.fromMap(maps[i]);
    });
  }

  /// Insère un nouveau rédacteur dans la base de données
  /// Retourne l'id du rédacteur inséré
  Future<int> insertRedacteur(Redacteur redacteur) async {
    final db = await database;

    // INSERT INTO redacteurs VALUES (...)
    int id = await db.insert(
      'redacteurs',           // Nom de la table
      redacteur.toMap(),      // Données à insérer (converties en Map)
      conflictAlgorithm: ConflictAlgorithm.replace, // Si conflit, remplacer
    );

    print('Rédacteur ajouté avec l\'id: $id');
    return id;
  }

  /// Met à jour les informations d'un rédacteur existant
  /// Retourne le nombre de lignes affectées (normalement 1)
  Future<int> updateRedacteur(Redacteur redacteur) async {
    final db = await database;

    // UPDATE redacteurs SET ... WHERE id = ?
    int count = await db.update(
      'redacteurs',           // Nom de la table
      redacteur.toMap(),      // Nouvelles données
      where: 'id = ?',        // Condition WHERE
      whereArgs: [redacteur.id], // Valeur pour remplacer le ?
    );

    print('Rédacteur mis à jour (lignes affectées: $count)');
    return count;
  }

  /// Supprime un rédacteur de la base de données
  /// Retourne le nombre de lignes supprimées (normalement 1)
  Future<int> deleteRedacteur(int id) async {
    final db = await database;

    // DELETE FROM redacteurs WHERE id = ?
    int count = await db.delete(
      'redacteurs',           // Nom de la table
      where: 'id = ?',        // Condition WHERE
      whereArgs: [id],        // Valeur pour remplacer le ?
    );

    print('Rédacteur supprimé (lignes affectées: $count)');
    return count;
  }

  /// Ferme la connexion à la base de données
  /// Utile pour libérer les ressources
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}