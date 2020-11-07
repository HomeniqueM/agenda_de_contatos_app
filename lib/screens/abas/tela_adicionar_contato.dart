import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  // Builder
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Novo contato",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      // Input nome
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Por favor entre com um nome'
                              : null,
                          onSaved: (input) => _nome = input,
                          initialValue: _nome,
                        ),
                      ),
                      // Input Email
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty
                              ? 'Por favor entre com um nome'
                              : null,
                          onSaved: (input) => _email = input,
                          initialValue: _email,
                        ),
                      ),
                      // Input numero
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Numero',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onSaved: (input) => _numero = input,
                          initialValue: _numero,
                        ),
                      ),
                      // Input endereço
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'endereço',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onSaved: (input) => _endereco = input,
                          initialValue: _endereco,
                        ),
                      ),
                      // Input Cep
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Cep',
                            labelStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onSaved: (input) => _cep = input,
                          initialValue: _cep,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Existe ,porém não vai ser usado
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
}
