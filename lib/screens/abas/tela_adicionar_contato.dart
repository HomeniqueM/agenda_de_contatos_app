import 'package:agenda_de_contatos_app/modelos/contato_model.dart';
import 'package:agenda_de_contatos_app/provider/contatos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  DateTime _Aniversario = DateTime.now();
  TextEditingController _controllercep = TextEditingController();
  TextEditingController _controllerEndereco = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MMM');

  // Builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Espaço entre a barra
                SizedBox(height: 10),
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
                          vertical: 15.0,
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
                          readOnly: true,
                          controller: _dateController,
                          onTap: _handleDatePick,
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            labelText: 'Aniversario',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: TextFormField(
                          controller: _controllercep,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            labelText: 'CEP',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        height: 30,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: FlatButton(
                          child: Text(
                            'Validar cep',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          onPressed: _handleCepPink,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: TextFormField(
                          controller: _controllerEndereco,
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            labelText: 'Endereço',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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
      Provider.of<ContatosProvider>(context, listen: false).loadAll(
        Contato(
          nome: _nome,
          email: _email,
          numero: _numero,
          cep: _controllercep.text,
          endereco: _endereco,
          aniversario: _dateController.text,
        ),
      );
      Provider.of<ContatosProvider>(context, listen: false).savaContato();
    }
  }

  _handleDatePick() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _Aniversario,
      firstDate: DateTime(1900),
      lastDate: DateTime(2300),
    );
    if (date != null && date != _Aniversario) {
      _dateController.text = _dateFormat.format(_Aniversario);
    }
    _dateController.text =_dateFormat.format(date).toString();
  }

  _handleCepPink() async {
    String _cepDigitado = _controllercep.text;
    print("Digitado: " + _cepDigitado);
    String url = "https://viacep.com.br/ws/$_cepDigitado/json/";

    http.Response response;
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    //configurar o _resultado
    _endereco = "${logradouro}, ${complemento}, ${bairro}, ${localidade} ";

    _controllerEndereco.text = _endereco.toString();
  }
}
