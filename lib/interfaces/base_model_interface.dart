import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IBaseModelInterface {
  String contatoId();
  Map toMap();
  Map toBaseMap();
  void fromBaseMap(DocumentSnapshot document);
}