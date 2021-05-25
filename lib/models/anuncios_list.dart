import 'package:meta/meta.dart';

import '../utils.dart';


class AnunciosListField {
  static final String createdAt = 'createdAt';
}

class AnunciosList {
  final String id;
  final String titulo;
  final String descripcion;
  final String imagen;
  final String creador;
  final DateTime createdAt;
  final DateTime updatedAt;
  final favoritos;

  const AnunciosList({
    @required this.id,
    @required this.titulo,
    @required this.descripcion,
    @required this.imagen,
    @required this.creador,
    @required this.createdAt,
    @required this.updatedAt,
    this.favoritos,
  });

  AnunciosList copyWith({
    String id,
    String titulo,
    String descripcion,
    String imagen,
    String creador,
    String createdAt,
    String updatedAt,
    favoritos,
  }) =>
      AnunciosList(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        descripcion: descripcion ?? this.descripcion,
        imagen: imagen ?? this.imagen,
        creador: creador ?? this.creador,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        favoritos: favoritos,
      );

  static AnunciosList fromJson(Map<String, dynamic> json) => AnunciosList(
    id: json['id'],
    titulo: json['titulo'],
    descripcion: json['descripcion'],
    imagen: json['imagen'],
    creador: json['creador'],
    createdAt: Utils.toDateTime(json['createdAt']),
    updatedAt: Utils.toDateTime(json['updatedAt']),
    favoritos: json['favoritos']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'titulo': titulo,
    'descripcion': descripcion,
    'imagen': imagen,
    'creador': creador,
    'createdAt': Utils.fromDateTimeToJson(createdAt),
    'updatedAt': Utils.fromDateTimeToJson(updatedAt),
    'favoritos': favoritos,
  };
}