import 'package:agenda_de_contatos_app/modelos/contato_model.dart';
import 'package:agenda_de_contatos_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class ContatoTile extends StatelessWidget {
  final Contato contato;

  const ContatoTile(this.contato);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(contato.nome),
        subtitle: Text(contato.email),
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        onTap: () {

          Navigator.of(context)
              .pushNamed(AppRoutes.EDITAR_CONTATO, arguments: contato);
        });
  }
}
