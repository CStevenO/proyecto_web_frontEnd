enum ProfesionsTypes{
  Cero,
  Abogado,
  Ingenieria_de_Sistemas,
  Administracion_de_Empresas,
  Psicologia
}

class MProfesion{
  final int? idProfesion;
  final String? pNombre;

  MProfesion({this.idProfesion = null,required this.pNombre});

  MProfesion.init({required this.idProfesion, this.pNombre = null});

  MProfesion.fromJson(Map<String, Object?> json)
   : this(
    idProfesion: json['idProfesion']! as int,
    pNombre: json['pNombre']! as String
  );

  Map<String, Object?> toJson(){
    Map<String,Object?> objects =  {
      'idProfesion': idProfesion,
      'pNombre': pNombre
    };
    objects.removeWhere((key, value) => value == null);
    return objects;
  }
}