import 'package:proyecto_web_frontend/modelos/model_aspirante.dart';
import 'package:intl/intl.dart';

import 'model_oferta.dart';

class MEmpleabilidad{
  final int? id;
  final DateTime eFecha;
  final MAspirante aspirante;
  final MOferta oferta;

  MEmpleabilidad({
    this.id = null,
    required this.eFecha,
    required this.aspirante,
    required this.oferta
  });

  MEmpleabilidad.fromJson(Map<String, Object?> json)
    : this(
    id: json['id']! as int,
    eFecha: DateTime.parse(json['eFecha']! as String),
    aspirante: MAspirante.fromJson(json['aspirante']! as Map<String, Object?>),
    oferta: MOferta.fromJson(json['oferta']! as Map<String, Object?>)
  );

  Map<String, Object?> toJson(){
    String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
    Map<String, Object?> objects = {
      'id': id,
      'eFecha': formatDate(eFecha),
      'aspirante': aspirante.toJson(),
      'oferta': oferta.toJson()
    };
    objects.removeWhere((key, value) => value == null);
    return objects;
  }
}