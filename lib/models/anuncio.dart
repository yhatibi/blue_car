import 'package:cloud_firestore/cloud_firestore.dart';

class Anuncio {
  String id;
  String titulo;
  String descripcion;
  String imagen;
  Timestamp createdAt;

  Anuncio.fromMap(Map<String, dynamic> data){
    id = data['id'];
    titulo = data['titulo'];
    descripcion = data['descripcion'];
    imagen = data['imagen'];
    createdAt = data['createdAt'];
  }
}