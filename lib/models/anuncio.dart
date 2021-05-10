import 'package:cloud_firestore/cloud_firestore.dart';

class Anuncio {
  String id;
  String titulo;
  String descripcion;
  String imagen;
  String creador;
  Timestamp createdAt;
  Timestamp updatedAt;

  Anuncio();

  Anuncio.fromMap(Map<String, dynamic> data){
    id = data['id'];
    titulo = data['titulo'];
    descripcion = data['descripcion'];
    imagen = data['imagen'];
    creador = data['creador'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'imagen': imagen,
      'creador': creador,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}