import 'package:agenda_de_contatos_app/interfaces/firebase_repository_base_interface.dart';
import 'package:agenda_de_contatos_app/modelos/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseRepositoyBase<Model extends BaseModel>
    implements IFirebaseRepositoryBaseInterface<Model> {
  final Model Function(DocumentSnapshot document) fromMap;
  final String collection;

  FirebaseRepositoyBase({this.fromMap, this.collection});

  @override
  Future<String> add(Model model) async {
    var collection = FirebaseFirestore.instance.collection(this.collection);
    var document = await collection.add(model.toMap());
    return document.id;
  }

  /**
   *
   */
  @override
  Future<void> update(Model model) async {
    var collection = FirebaseFirestore.instance.collection(this.collection);
    await collection.doc(model.documentId()).update(model.toMap());
  }

  /** delete
   *
   */
  @override
  Future<void> delete(String documentId) async {
    var collection = FirebaseFirestore.instance.collection(this.collection);
    await collection.doc(documentId).delete();
  }

  @override
  CollectionReference filter() {
    return FirebaseFirestore.instance.collection(collection);
  }

  /** fromSnapshotToModelList
   *
   */
  @override
  List<Model> fromSnapshotToModelList(List<DocumentSnapshot> documentList) {
    List<Model> list = [];
    documentList.forEach((element) {
      list.add(fromMap(element));
    });
  }

  @override
  Future<List<Model>> getAll() async {
    var collection = FirebaseFirestore.instance.collection(this.collection);
    List<Model> list = [];
    var querySnapshot = await collection.get();
    await querySnapshot.docs.forEach((element) {
      list.add(fromMap(element));
    });
    return await list;
  }

  @override
  Future<Model> getById(String documentId) async {
    var collection = FirebaseFirestore.instance.collection(this.collection);
    var snapshot = await collection.doc(documentId).get();
    return fromMap(snapshot);
  }
}
