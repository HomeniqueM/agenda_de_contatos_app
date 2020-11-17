import 'package:agenda_de_contatos_app/modelos/contato_model.dart';
import 'package:agenda_de_contatos_app/provider/contatos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditarContato extends StatefulWidget {
  // Definições
  final Contato editcotato;

  const EditarContato(this.editcotato);

  @override
  _EditarContatoState createState() => _EditarContatoState();
}

class _EditarContatoState extends State<EditarContato> {
  final _formkey = GlobalKey<FormState>();
  final Map<String, String> _forData = {};

  DateTime _Aniversario = DateTime.now();
  TextEditingController _controllercep = TextEditingController();
  TextEditingController _controllerEndereco = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MMM');

  @override
  Widget build(BuildContext context) {
    final Contato contato = ModalRoute.of(context).settings.arguments;
    _loadFormData(contato);

    return Scaffold(
        appBar: AppBar(
          title: Text('Editar contato'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.grey,
                size: 40,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Excluir usuário'),
                    content: Text('Confirmar?'),
                    actions: <Widget>[
                      FlatButton(
                        // Fechar a caixa de dialogo
                        onPressed: () {
                          print("Contato ID:" + contato.id);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Não',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Provider.of<ContatosProvider>(context, listen: false)
                              .removeContato(contato.id);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Sim',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 50,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        _lerNome(),
                        _lerNumero(),
                        _lerEmail(),
                        _lerAniversario(),
                        _lerCEP(),
                        _botaoDevalidacaodeCep(context),
                        carregarEndereco(),
                        _botaoDeAlterar(context)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Container _botaoDeAlterar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: FlatButton(
        child: Text(
          'Alterar',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        onPressed: _salvar,
      ),
    );
  }

  Container _botaoDevalidacaodeCep(BuildContext context) {
    return Container(
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
    );
  }

  Padding carregarEndereco() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        controller: _controllerEndereco,
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          labelText: 'Endereço',
          labelStyle: TextStyle(fontSize: 18.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Padding _lerCEP() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        controller: _controllercep,
        style: TextStyle(fontSize: 18.0),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'CEP',
          labelStyle: TextStyle(fontSize: 18.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Padding _lerEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(fontSize: 18.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onSaved: (input) => _forData['email'] = input,
        initialValue: _forData['email'],
      ),
    );
  }

  Padding _lerAniversario() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        readOnly: true,
        controller: _dateController,
        style: TextStyle(fontSize: 18.0),
        onTap: _handleDatePick,
        decoration: InputDecoration(
          labelText: 'Aniversario',
          labelStyle: TextStyle(fontSize: 18.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Padding _lerNumero() {
    return Padding(
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
        validator: (input) =>
            input.trim().length > 14 ? "Numero invalido" : null,
        onSaved: (input) => _forData['numero'] = input,
        initialValue: _forData['numero'],
      ),
    );
  }

  Padding _lerNome() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          labelText: 'Nome',
          labelStyle: TextStyle(fontSize: 18.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (input) =>
            input.trim().isEmpty ? 'Por favor, entrer com um nome' : null,
        onSaved: (input) => _forData['nome'] = input,
        initialValue: _forData['nome'],
      ),
    );
  }

  _salvar() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      Provider.of<ContatosProvider>(context, listen: false).loadAll(
        Contato(
          id: _forData['id'],
          nome: _forData['nome'],
          email: _forData['email'],
          numero: _forData['numero'],
          cep: _controllercep.text,
          endereco: _controllerEndereco.text,
          aniversario: _dateController.text,
        ),
      );
      Provider.of<ContatosProvider>(context, listen: false).savaContato();
      Navigator.of(context).pop();
    }
  }

  void _loadFormData(Contato contato) {
    _forData['id'] = contato.id;
    _forData['nome'] = contato.nome;
    _forData['numero'] = contato.numero;
    _forData['email'] = contato.email;
    _controllercep.text = contato.cep;
    _controllerEndereco.text = contato.endereco;
    _dateController.text = contato.aniversario;
    print("Digitado: " + _controllercep.text);
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
    _dateController.text = _dateFormat.format(date).toString();
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
    _forData['endereco'] =
        "${logradouro}, ${complemento}, ${bairro}, ${localidade} ";

    _controllerEndereco.text = _forData['endereco'].toString();
  }
}
