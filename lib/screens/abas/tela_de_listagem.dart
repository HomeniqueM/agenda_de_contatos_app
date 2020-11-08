import 'package:agenda_de_contatos_app/modelo/contato_modelo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListagemContatos extends StatefulWidget {
  @override
  _ListagemContatosState createState() => _ListagemContatosState();
}

class _ListagemContatosState extends State<ListagemContatos> {
  Future<List<Contato>> _contatoList;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('contatos').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(

          // Quantidade de elementos exibidos na tela
          itemCount: snapshot.data.docs.length,
          // Criar o lista de contatos
          itemBuilder: (BuildContext context, int index) {
            var item = snapshot.data.documents[index].data();
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListTile(
                    title: Text(
                      item['nome'],
                    ),
                    subtitle: Text(item['email']),
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
          },
        );
      },
    );
  }

  // Cada contato
  _contato() {
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

  _updateAgenda(){
    Future.delayed(Duration.zero, ()=>setState(
        (){

        }
    ));
  }
}
