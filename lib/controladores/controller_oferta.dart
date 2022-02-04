import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:proyecto_web_frontend/exceptions/errors.dart';
import 'package:proyecto_web_frontend/modelos/model_oferta.dart';

import 'crud_model.dart';

class COferta extends Crud<MOferta>{
  static const String api = 'oferta/';
  COferta();
  @override
  Future<MOferta> consultar(int id) async{
    var url = Uri.parse(Crud.endpoint+api+id.toString());
    var response = await http.get(url);
    if(response.statusCode == 200){
      String data = convert.utf8.decode(response.bodyBytes);
      final jsonData = convert.jsonDecode(data);
      return MOferta.fromJson(jsonData);
    }
    throw ReachError();
  }

  @override
  Future<MOferta> crear(MOferta objecto) async{
    var url = Uri.parse(Crud.endpoint+api);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode(objecto.toJson())
    );
    if(response.statusCode == 200){
      String data = convert.utf8.decode(response.bodyBytes);
      final jsonData = convert.jsonDecode(data);
      return MOferta.fromJson(jsonData);
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
  Future<List<MOferta>> listar() async{
    var url = Uri.parse(Crud.endpoint+api);
    var response = await http.get(url,
        headers: {"Content-Type": "application/text"});
    if (response.statusCode == 200) {
      String data = convert.utf8.decode(response.bodyBytes);
      final List<dynamic> jsonData = convert.jsonDecode(data);
      return jsonData.map((i)=>MOferta.fromJson(i)).toList();
    }
    throw ReachError();
  }

  Future<List<MOferta>> habilitados() async{
    var url = Uri.parse(Crud.endpoint+api+'habilitados');
    var response = await http.get(url,
        headers: {"Content-Type": "application/text"});
    if (response.statusCode == 200) {
      String data = convert.utf8.decode(response.bodyBytes);
      final List<dynamic> jsonData = convert.jsonDecode(data);
      return jsonData.map((i)=>MOferta.fromJson(i)).toList();
    }
    throw ReachError();
  }

}