import 'package:agenda_de_contatos_app/modelos/contato_model.dart';
import 'package:agenda_de_contatos_app/provider/contatos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  TextEditingController _dataController = TextEditingController();

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
                color: Colors.red[500],
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
                        carregarEndereco(),
                        Container(
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
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            onPressed: _salvar,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Padding carregarEndereco() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        readOnly: true,
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          labelText: 'Endereço',
          labelStyle: TextStyle(fontSize: 18.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onSaved: (input) => _forData['endereco'] = input,
        initialValue: _forData['endereco'],
      ),
    );
  }

  Padding _lerCEP() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          labelText: 'CEP',
          labelStyle: TextStyle(fontSize: 18.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onSaved: (input) => _forData['cep'] = input,
        initialValue: _forData['cep'],
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
        controller: _dataController,
        style: TextStyle(fontSize: 18.0),
        onTap: () => {},
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
          cep: _forData['cep'],
          endereco: _forData['endereco'],
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
    _forData['cep'] = contato.cep;
    _forData['endereco'] = contato.endereco;
  }
}
