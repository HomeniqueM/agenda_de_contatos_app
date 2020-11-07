import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListagemContatos extends StatefulWidget {
  @override
  _ListagemContatosState createState() => _ListagemContatosState();
}

class _ListagemContatosState extends State<ListagemContatos> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // padding: EdgeInsets.symmetric(vertical: 80.0),
      // Quantidade de elementos exibidos na tela
      itemCount: 10,
      // Criar o lista de contatos
      itemBuilder: (BuildContext context, int index) {
        return _contato(index);
      },
    );
  }

  // Cada contato
  _contato(int index) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ListTile(
            title: Text(
              'Nome',
            ),
            subtitle: Text('Email'),
            leading: CircleAvatar(
              child: Icon(
                Icons.account_box_sharp,
                color: Colors.amber,
                size: 50,
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
