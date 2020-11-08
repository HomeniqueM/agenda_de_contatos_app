import 'package:flutter/cupertino.dart';

class Contato {
  final String id;
  final String nome;
  final String email;
  final String numero;
  final String endereco;
  final String cep;

  Contato(
      {@required this.id, this.nome, this.email, this.numero, this.endereco, this.cep});

  // Deserializar objeto
  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      id      : json['id'],
      nome    : json['nome'],
      email   : json['email'],
      numero  : json['numero'],
      endereco: json['endereco'],
      cep     : json['cep'],
    );
  }
  // Seriazador de objeto
  Map<String, dynamic> toMap() {
    return {
      'id'      : id,
      'nome'    : nome,
      'email'   : email,
      'numero'  : numero,
      'endereco': endereco,
      'cep'     : cep
    };
  }


}
