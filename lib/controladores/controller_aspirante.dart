import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:proyecto_web_frontend/exceptions/errors.dart';
import 'package:proyecto_web_frontend/modelos/model_aspirante.dart';
import 'package:proyecto_web_frontend/modelos/model_profesion.dart';

import 'crud_model.dart';

class CAspirante extends Crud<MAspirante>{
  static const String api = 'aspirante/';
  CAspirante();

  @override
  Future<MAspirante> consultar(int id) async{
    var url = Uri.parse(Crud.endpoint+api+id.toString());
    var response = await http.get(url);
    if(response.statusCode == 200){
      String data = convert.utf8.decode(response.bodyBytes);
      final jsonData = convert.jsonDecode(data);
      return jsonData != null ? MAspirante.fromJson(jsonData): throw EmptyError();
    }
    throw ReachError();
  }

  @override
  Future<MAspirante> crear(MAspirante objecto) async{
    var url = Uri.parse(Crud.endpoint+api);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode(objecto.toJson())
    );
    if(response.statusCode == 200){
      String data = convert.utf8.decode(response.bodyBytes);
      final jsonData = convert.jsonDecode(data);
      return MAspirante.fromJson(jsonData);
    }
    throw ReachError();
  }

  @override
  Future<String> eliminar(int id) async{
    var url = Uri.parse(Crud.endpoint+api+id.toString());
    var response = await http.delete(url,
        headers: {"Content-Type": "application/text"}
    );
    if(response.statusCode == 200){
      return convert.utf8.decode(response.bodyBytes);
    }
    throw ReachError();
  }

  @override
  Future<List<MAspirante>> listar() async{
    var url = Uri.parse(Crud.endpoint+api);
    var response = await http.get(url,
        headers: {"Content-Type": "application/text"});
    if (response.statusCode == 200) {
      String data = convert.utf8.decode(response.bodyBytes);
      final List<dynamic> jsonData = convert.jsonDecode(data);
      return jsonData.map((i)=>MAspirante.fromJson(i)).toList();
    }
    throw ReachError();
  }

  Future<MAspirante> obtenerMayor() async{
    var url = Uri.parse(Crud.endpoint+api+'mayor');
    var response = await http.get(url);
    if(response.statusCode == 200){
      String data = convert.utf8.decode(response.bodyBytes);
      final jsonData = convert.jsonDecode(data);
      return jsonData != null ? MAspirante.fromJson(jsonData): throw EmptyError();
    }
    throw ReachError();
  }

  Future<List<MAspirante>> obtenerDiferente(var url) async{
    var response = await http.get(url,
        headers: {"Content-Type": "application/text"});
    if (response.statusCode == 200) {
      String data = convert.utf8.decode(response.bodyBytes);
      final List<dynamic> jsonData = convert.jsonDecode(data);
      return jsonData.map((i)=>MAspirante.fromJson(i)).toList();
    }
    throw ReachError();
  }

  Future<List<MAspirante>> obtenerPorLetra(String letra) async{
    var url = Uri.parse(Crud.endpoint+api+'letra/'+letra);
    return obtenerDiferente(url);
  }

  Future<List<MAspirante>> obtenerPorGeneroProfesion(String genero, ProfesionsTypes tipo){
    var url = Uri.parse(Crud.endpoint+api+'generoprofesion/'+genero+'/'+tipo.index.toString());
    return obtenerDiferente(url);
  }

  Future<List<MAspirante>> porProfesion(int idProfesion){
    var url = Uri.parse(Crud.endpoint+api+'profesion/'+idProfesion.toString());
    return obtenerDiferente(url);
  }
}