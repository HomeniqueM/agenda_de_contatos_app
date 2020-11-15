import 'package:agenda_de_contatos_app/modelos/contato_model.dart';
import 'package:agenda_de_contatos_app/services/firebase_repository_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContatoRepository extends FirebaseRepositoyBase<Contato> {
  @override
  String get collection => 'contatos';

  @override
  Contato Function(DocumentSnapshot document) get froMap =>
      (document) => Contato.fromMap(document);
}
