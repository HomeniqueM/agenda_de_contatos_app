import 'dart:math';
import 'package:agenda_de_contatos_app/data/firebase_contatos.dart';
import 'package:agenda_de_contatos_app/modelos/contato_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ContatosProvider with ChangeNotifier {
  final firestoreService = FirebaseContatos();

  String _id;
  String _nome;
  String _email;
  String _numero;
  String _endereco;
  String _cep;
  String _aniversario;
  var uuid = Uuid();

  // Gets
  String get id => _id;

  String get nome => _nome;

  String get email => _email;

  String get numero => _numero;

  String get endereco => _endereco;

  String get cep => _cep;

  String get aniversario => _aniversario;

  Stream<List<Contato>> get Contatos => firestoreService.getContatos();

  // setters
  set changeNome(String nome) {
    _nome = nome;
    notifyListeners();
  }

  set changeEmail(StringEmail) {
    _email = email;
    notifyListeners();
  }

  set changeNumero(String numero) {
    _numero = numero;
    notifyListeners();
  }

  set changeEndereco(String endereco) {
    _endereco = endereco;
    notifyListeners();
  }

  set changeCep(String cep) {
    _cep = cep;
    notifyListeners();
  }

  // Funcoes

  loadAll(Contato contato) {
    if (contato != null) {
      _id = contato.id;
      _nome = contato.nome;
      _email = contato.email;
      _numero = contato.numero;
      _endereco = contato.endereco;
      _cep = contato.cep;
      _aniversario = contato.aniversario;
    } else {
      _id = null;
      _nome = null;
      _email = null;
      _numero = null;
      _endereco = null;
      _cep = null;
      _aniversario = null;
    }
  }

  savaContato() {
    // add
    if (_id == null) {
      var novoContato = Contato(
          nome: _nome,
          email: _email,
          numero: _numero,
          cep: _cep,
          endereco: _endereco,
          aniversario: _aniversario,
          id: uuid.v1());
      firestoreService.setContato(novoContato);
    } else {
      var updateContato = Contato(
        nome: _nome,
        email: _email,
        numero: _numero,
        cep: _cep,
        endereco: _endereco,
        aniversario: _aniversario,
      );
      firestoreService.setContato(updateContato);
    }
  }

  removeContato(String id) {
    firestoreService.removeContato(id);
  }
}
