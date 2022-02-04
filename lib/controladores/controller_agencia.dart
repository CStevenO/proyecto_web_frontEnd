import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:proyecto_web_frontend/controladores/crud_model.dart';
import 'package:proyecto_web_frontend/exceptions/errors.dart';
import 'package:proyecto_web_frontend/modelos/model_agencia.dart';

class CAgencia extends Crud<MAgencia>{
  static const String api = 'agencia/';
  CAgencia();
  @override
  Future<MAgencia> consultar(int id) async{
    var url = Uri.parse(Crud.endpoint+api+id.toString());
    var response = await http.get(url);
    if(response.statusCode == 200){
      String data = convert.utf8.decode(response.bodyBytes);
      final jsonData = convert.jsonDecode(data);
      return MAgencia.fromJson(jsonData);
    }
    throw ReachError();
  }

  @override
  Future<MAgencia> crear(MAgencia objecto) async{
    var url = Uri.parse(Crud.endpoint+api);
    var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: convert.jsonEncode(objecto.toJson())
    );
    if(response.statusCode == 200){
      String data = convert.utf8.decode(response.bodyBytes);
      final jsonData = convert.jsonDecode(data);
      return MAgencia.fromJson(jsonData);
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
  Future<List<MAgencia>> listar() async{
    var url = Uri.parse(Crud.endpoint+api);
    var response = await http.get(url,
        headers: {"Content-Type": "application/text"});
    if (response.statusCode == 200) {
      String data = convert.utf8.decode(response.bodyBytes);
      final List<dynamic> jsonData = convert.jsonDecode(data);
      return jsonData.map((i)=>MAgencia.fromJson(i)).toList();
    }
    throw ReachError();
  }
  
}