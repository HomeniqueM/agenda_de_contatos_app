import 'package:agenda_de_contatos_app/interfaces/base_model_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BaseModel extends IBaseModelInterface{
  // Para instaciação do objeto
  BaseModel();
  BaseModel.fromMap(DocumentSnapshot document);
  String id;

  @override
  String contatoId() {
    // TODO: implement contatoId
    throw UnimplementedError();
  }

  @override
  void fromBaseMap(DocumentSnapshot document) {
    id = document.id;
  }
  @override
  Map toBaseMap() {
    // TODO: implement toBaseMap
    throw UnimplementedError();
  }

  @override
  Map toMap() => null;
  String documentId() =>id;


}