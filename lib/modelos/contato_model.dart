import 'package:agenda_de_contatos_app/modelos/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Contato extends BaseModel {
  String nome;
  String email;
  String numero;
  String endereco;
  String cep;

  Contato({this.nome, this.numero, this.email, this.cep, this.endereco});

  Contato.fromMap(DocumentSnapshot document) {
    fromBaseMap(document);
    nome      = document["nome"];
    email     = document["email"];
    numero    = document['numero'];
    endereco  = document['endereco'];
    cep       = document['cep'];
  }
  // Seriazador de objeto
  Map<String, dynamic> toMap() {
    return {
      'nome'    : nome,
      'email'   : email,
      'numero'  : numero,
      'endereco': endereco,
      'cep'     : cep
    };
  }
}
