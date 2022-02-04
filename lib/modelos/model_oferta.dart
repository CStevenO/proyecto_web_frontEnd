import 'package:intl/intl.dart';

class MOferta{
  final int? id;
  final String? oDescripcion;
  final DateTime? oFechaInicio;
  final DateTime? oFechaFin;
  final String? oNombre;

  MOferta({
    this.id = null,
    required this.oDescripcion,
    required this.oFechaInicio,
    required this.oFechaFin,
    required this.oNombre
  });

  MOferta.init({
    required this.id,
    this.oDescripcion = null,
    this.oFechaInicio = null,
    this.oFechaFin = null,
    this.oNombre = null
  });

  MOferta.fromJson(Map<String, Object?> json)
    : this(
    id: json['id']! as int,
    oDescripcion: json['odescripcion']! as String,
    oFechaInicio: DateTime.parse(json['ofechaInicio']! as String),
    oFechaFin: DateTime.parse(json['ofechaFin']! as String),
    oNombre: json['onombre']! as String
  );

  Map<String, Object?> toJson(){
    String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
    Map<String, Object?> objects = {
      'id': id,
      'odescripcion': oDescripcion,
      'ofechaInicio': oFechaInicio == null ? null:formatDate(oFechaInicio!),
      'ofechaFin': oFechaFin == null ? null:formatDate(oFechaFin!),
      'onombre': oNombre
    };
    objects.removeWhere((key, value) => value == null || value == 'null');
    return objects;
  }
}