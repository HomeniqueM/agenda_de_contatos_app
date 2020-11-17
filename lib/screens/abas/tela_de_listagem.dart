import 'package:agenda_de_contatos_app/components/contato_tile.dart';
import 'package:agenda_de_contatos_app/modelos/contato_model.dart';
import 'package:agenda_de_contatos_app/provider/contatos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListagemContatos extends StatefulWidget {
  @override
  _ListagemContatosState createState() => _ListagemContatosState();
}

class _ListagemContatosState extends State<ListagemContatos> {
  @override
  Widget build(BuildContext context) {
    final contatosProvide = Provider.of<ContatosProvider>(context);
    return StreamBuilder<List<Contato>>(
      stream: contatosProvide.Contatos,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          // Quantidade de elementos exibidos na tela
          itemCount: snapshot.data.length,

          // Criar o lista de contatos
          itemBuilder: (BuildContext context, int index) =>
              ContatoTile(snapshot.data[index]),
        );
      },
    );
  }
}
