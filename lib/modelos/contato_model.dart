import 'package:cloud_firestore/cloud_firestore.dart';

class Contato {
  final String id;
  final String nome;
  final String email;
  final String numero;
  final String endereco;
  final String cep;
  final String aniversario;

  const Contato(
      {this.id,
      this.nome,
      this.numero,
      this.email,
      this.cep,
      this.endereco,
      this.aniversario});

  factory Contato.froJson(Map<String, dynamic> json) {
    return Contato(
      id          : json['id'],
      nome        : json['nome'],
      email       : json['email'],
      numero      : json['numero'],
      endereco    : json['endereco'],
      cep         : json['cep'],
      aniversario : json['aniversario'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id'          : id,
      'nome'        : nome,
      'email'       : email,
      'numero'      : numero,
      'endereco'    : endereco,
      'cep'         : cep,
      'aniversario' : aniversario,
    };
  }
}
