class MAgencia{
  final int idAgencia;
  final String? agNombre;
  final String? agTelefono;
  final String? agDireccion;

  MAgencia({
    required this.idAgencia,
    required this.agNombre,
    required this.agTelefono,
    required this.agDireccion
  });

  MAgencia.init({
    required this.idAgencia,
    this.agDireccion = null,
    this.agTelefono = null,
    this.agNombre = null
  });

  MAgencia.fromJson(Map<String, Object?> json)
    : this(
    idAgencia: json['id']! as int,
    agNombre: json['agNombre']! as String,
    agTelefono: json['agTelefono']! as String,
    agDireccion: json['agDireccion']! as String
  );

  Map<String, Object?> toJson(){
    Map<String, Object?> objects = {
      'id': idAgencia,
      'agNombre': agNombre,
      'agTelefono': agTelefono,
      'agDireccion': agDireccion
    };
    objects.removeWhere((key, value) => value == null);
    return objects;
  }
}