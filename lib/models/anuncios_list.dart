import 'package:meta/meta.dart';

import '../utils.dart';


class AnunciosListField {
  static final String createdAt = 'createdAt';
}

class AnunciosList {
  final String id;
  final String titulo;
  final String descripcion;
  final String creador;
  final DateTime createdAt;
  final DateTime updatedAt;
  final favoritos;
  final imagenes;
  final String ano;
  final String cavallos;
  final String combustible;
  final String kilometros;
  final String precio;
  final String puertas;


  const AnunciosList({
    @required this.id,
    @required this.titulo,
    @required this.descripcion,
    @required this.imagenes,
    @required this.creador,
    @required this.createdAt,
    @required this.updatedAt,
    this.favoritos,
    this.ano,
    this.cavallos,
    this.combustible,
    this.kilometros,
    this.precio,
    this.puertas,
  });

  AnunciosList copyWith({
    String id,
    String titulo,
    String descripcion,
    imagenes,
    String creador,
    String createdAt,
    String updatedAt,
    favoritos,
    String ano,
    String cavallos,
    String combustible,
    String kilometros,
    String precio,
    String puertas,

  }) =>
      AnunciosList(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        descripcion: descripcion ?? this.descripcion,
        imagenes: imagenes ?? this.imagenes,
        creador: creador ?? this.creador,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        ano: ano ?? this.ano,
        cavallos: cavallos ?? this.cavallos,
        combustible: combustible ?? this.combustible,
        kilometros: kilometros ?? this.kilometros,
        precio: precio ?? this.precio,
        puertas: puertas ?? this.puertas,
        favoritos: favoritos,
      );

  static AnunciosList fromJson(Map<String, dynamic> json) => AnunciosList(
    id: json['id'],
    titulo: json['titulo'],
    descripcion: json['descripcion'],
    imagenes: json['imagenes'],
    creador: json['creador'],
    createdAt: Utils.toDateTime(json['createdAt']),
    updatedAt: Utils.toDateTime(json['updatedAt']),
    favoritos: json['favoritos'],
    ano: json['ano'],
    cavallos: json['cavallos'],
    combustible: json['combustible'],
    kilometros: json['kilometros'],
    precio: json['precio'],
    puertas: json['puertas']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'titulo': titulo,
    'descripcion': descripcion,
    'imagenes': imagenes,
    'creador': creador,
    'createdAt': Utils.fromDateTimeToJson(createdAt),
    'updatedAt': Utils.fromDateTimeToJson(updatedAt),
    'favoritos': favoritos,
    'ano': ano,
    'cavallos': cavallos,
    'combustible': combustible,
    'kilometros': kilometros,
    'creador': creador,
    'precio': precio,
    'puertas': puertas,
  };
}