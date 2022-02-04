import 'package:proyecto_web_frontend/exceptions/errors.dart';
import 'package:proyecto_web_frontend/modelos/model_empleabilidad.dart';
import 'dart:convert' as convert;
import 'crud_model.dart';
import 'package:http/http.dart' as http;

class CEmpleabilidad extends Crud<MEmpleabilidad>{
  static const String api = 'empleabilidad/';
  CEmpleabilidad();

  @override
  Future<MEmpleabilidad> consultar(int id) async{
    var url = Uri.parse(Crud.endpoint+api+id.toString());
    var response = await http.get(url);
    if(response.statusCode == 200){
      String data = convert.utf8.decode(response.bodyBytes);
      final jsonData = convert.jsonDecode(data);
      return MEmpleabilidad.fromJson(jsonData);
    }
    throw ReachError();
  }

  @override
  Future<MEmpleabilidad> crear(MEmpleabilidad objecto) async{
    var url = Uri.parse(Crud.endpoint+api);
    print(objecto.toJson().toString());
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode(objecto.toJson())
    );
    print(response.statusCode);
    if(response.statusCode == 200){
      String data = convert.utf8.decode(response.bodyBytes);
      final jsonData = convert.jsonDecode(data);
      return objecto;
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
  Future<List<MEmpleabilidad>> listar() async{
    var url = Uri.parse(Crud.endpoint+api);
    var response = await http.get(url,
        headers: {"Content-Type": "application/text"});
    if (response.statusCode == 200) {
      String data = convert.utf8.decode(response.bodyBytes);
      final List<dynamic> jsonData = convert.jsonDecode(data);
      return jsonData.map((i)=>MEmpleabilidad.fromJson(i)).toList();
    }
    throw ReachError();
  }

}