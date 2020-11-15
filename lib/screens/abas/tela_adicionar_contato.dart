import 'package:agenda_de_contatos_app/interfaces/firebase_repository_base_interface.dart';
import 'package:agenda_de_contatos_app/modelos/contato_model.dart';
import 'package:agenda_de_contatos_app/screens/abas/tela_de_listagem.dart';
import 'package:agenda_de_contatos_app/screens/abas/tela_editar_contato.dart';
import 'package:agenda_de_contatos_app/services/contato_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class AdicionarContato extends StatefulWidget {
  @override
  _AdicionarContatoState createState() => _AdicionarContatoState();
}

class _AdicionarContatoState extends State<AdicionarContato> {
  // Definições
  final _formkey = GlobalKey<FormState>();
  String _email = '';
  String _nome = '';
  String _endereco = '';
  String _numero = '';
  String _cep = ''; // vou ler como String,porém armazenar com int
  String id;
  ContatoRepository contatoRepository;
  @override
  void initState() {
    contatoRepository =Modular.get<IFirebaseRepositoryBaseInterface>();
        super.initState();
  }
  // Builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Espaço entre a barra
                SizedBox(height: 20),
                Text(
                  'Novo Contato',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: TextFormField(
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? "Por favor informe um nome"
                              : null,
                          onSaved: (input) => _nome = input,
                          initialValue: _nome,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            labelText: 'Numero',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          //+xx(XX)xxxx-xxxx
                          validator: (input) => input.trim().length > 14
                              ? "Numero invalido"
                              : null,
                          onSaved: (input) => _numero = input,
                          initialValue: _numero,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (input) => input.trim().length > 100
                              ? "Por favor informe um email valido"
                              : null,
                          onSaved: (input) => _email = input,
                          initialValue: _email,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: TextFormField(
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            labelText: 'Endereço',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (input) => input.trim().length > 150
                              ? "Por favor, informe um endereço valido"
                              : null,
                          onSaved: (input) => _endereco = input,
                          initialValue: _endereco,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            labelText: 'CEP',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (input) => input.trim().length > 10
                              ? "Por favor, informe um CEP valido"
                              : null,
                          onSaved: (input) => _cep = input,
                          initialValue: _cep,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: FlatButton(
                          child: Text(
                            'Adicionar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: _submit,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      var user = Contato(
        nome: _nome,
        numero: _numero,
        email: _email,
        endereco: _endereco,
        cep: _cep,
      );
      id = contatoRepository.add(user) as String;
    }
  }
}
