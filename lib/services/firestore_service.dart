import 'package:agenda_de_contatos_app/modelo/contato_modelo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;


  // Get Entries
  Stream<List<Contato>> getContatos() {
    return _db.collection('usuarios').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Contato.fromJson(doc.data())).toList());
  }
  
  //Upsert
  Future<void>setContato(Contato contato){
    var options = SetOptions(merge: true);
    return _db.collection('usuarios').doc(contato.id).set(contato.toMap(),options );
  }

  // Delete
  Future<void> removecontato(String contatoId){
    return _db.collection('usuarios').doc(contatoId).delete();
  }
}
