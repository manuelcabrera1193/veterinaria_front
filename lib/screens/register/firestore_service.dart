import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Función para agregar un documento a Firestore
  Future<DocumentReference<Map<String, dynamic>>> addDocument(String collection, Map<String, dynamic> data) {
    return _db.collection(collection).add(data);
  }

  Future<List<dynamic>> getTasks(String collection) async {
    final snapshot = await _db.collection(collection).get();
    return snapshot.docs.map((doc)=> doc.data()).toList();
  }

  // Función para leer un documento a Firestore
  Future<DocumentSnapshot<Map<String, dynamic>>> readData(
      String collectionName, String documentId) async {
    return await _db.collection(collectionName).doc(documentId).get();
  }

  // Función para actualizar un documento en Firestore
  Future<void> updateDocument(
      String collection, String docId, Map<String, dynamic> data) {
    return _db.collection(collection).doc(docId).update(data);
  }

  // Función para eliminar un documento de Firestore
  Future<void> deleteDocument(String collection, String docId) {
    return _db.collection(collection).doc(docId).delete();
  }
}
