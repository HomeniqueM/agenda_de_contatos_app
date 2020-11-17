import 'package:agenda_de_contatos_app/modelos/contato_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseContatos {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  String _namedb = 'contatos';

// Gets
  Stream<List<Contato>> getContatos() {
    return _db.collection(_namedb).snapshots().map((snapshots) => snapshots.docs
        .map(
          (doc) => Contato.froJson(
            doc.data(),
          ),
        )
        .toList());
  }

  //Create / update
  Future<void> setContato(Contato contato) {
    var options = SetOptions(merge: true);
    return _db.collection(_namedb).doc(contato.id).set(contato.toMap());
  }

  // delete
  Future<void> removeContato(String id) {
    return _db.collection(_namedb).doc(id).delete();
  }
}
