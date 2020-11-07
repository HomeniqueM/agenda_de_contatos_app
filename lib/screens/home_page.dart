import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage  extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    var tamanhoTela =MediaQuery.of(context).size; // Tamanho total da tela
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(
            "Agenda de contatos",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w700),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Listar',icon: Icon(Icons.account_box_outlined),),
              Tab(text: 'Adicionar',icon: Icon(Icons.add_call),),
              Tab(text: 'Atualizar',icon: Icon(Icons.assignment_sharp),)
            ],
          ),
        ),

      ),
    );
  }

}

