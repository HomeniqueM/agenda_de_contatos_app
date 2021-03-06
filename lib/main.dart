import 'package:agenda_de_contatos_app/provider/contatos.dart';
import 'package:agenda_de_contatos_app/routes/app_routes.dart';
import 'package:agenda_de_contatos_app/screens/home_page.dart';
import 'package:agenda_de_contatos_app/screens/tela_editar_contato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContatosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aplicativo de Notas',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          secondaryHeaderColor: Colors.amber[50],
        ),
        home: HomePage(),
        routes: {
          AppRoutes.EDITAR_CONTATO: (_) => EditarContato(null)
        },
      ),
    );
  }
}
