import 'package:proyecto_web_frontend/modelos/model_agencia.dart';
import 'package:proyecto_web_frontend/modelos/model_profesion.dart';

enum GeneroPersona{
  F,
  M,
  O
}

class MAspirante{
  final int id;
  final String? asNombre;
  final String? asGenero;
  final int? asEdad;
  final MAgencia? agencia;
  final MProfesion? profesion;

  MAspirante({
    required this.id,
    required this.asNombre,
    required this.asGenero,
    required this.asEdad,
    required this.agencia,
    required this.profesion
  });

  MAspirante.init({
    required this.id,
    this.profesion = null,
    this.agencia = null,
    this.asNombre = null,
    this.asEdad = null,
    this.asGenero = null
  });

  List<String> toList(){
    return [
      id.toString(),
      asNombre.toString(),
      asEdad.toString(),
      asGenero.toString(),
      profesion!.idProfesion.toString(),
      agencia!.idAgencia.toString(),
    ];
  }

  MAspirante.fromJson(Map<String, Object?> json)
   : this(
    id: json['id']! as int,
    asNombre: json['asNombre']! as String,
    asGenero: json['asGenero']! as String,
    asEdad: json['asEdad']! as int,
    agencia: MAgencia.fromJson(json['agencia']! as Map<String, Object?>),
    profesion: MProfesion.fromJson(json['profesion']! as Map<String, Object?>)
  );

  Map<String, Object?> toJson(){
    Map<String, Object?> objects = {
      'id': id,
      'asNombre': asNombre,
      'asGenero': asGenero,
      'asEdad': asEdad,
      'agencia': agencia?.toJson(),
      'profesion': profesion?.toJson()
    };
    objects.removeWhere((key, value) => value == null);
    return objects;
  }
}