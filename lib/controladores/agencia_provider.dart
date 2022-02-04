import 'package:flutter/foundation.dart';
import 'package:proyecto_web_frontend/controladores/controller_agencia.dart';
import 'package:proyecto_web_frontend/exceptions/errors.dart';
import 'package:proyecto_web_frontend/modelos/model_agencia.dart';

class AgenciaManager extends ChangeNotifier {
  final CAgencia _cAgencia = CAgencia();
  MAgencia? _agencia = null;

  MAgencia? get getAgencia => _agencia;

  set agencia(MAgencia agencia){
    _agencia = agencia;
    notifyListeners();
  }

  bool isLoggedIn(){
    return _agencia != null;
  }

  Future<String?> signup(MAgencia newAgencia) async{
    MAgencia mAgencia = await _cAgencia.crear(newAgencia);
    _agencia = mAgencia;
    notifyListeners();
  }

  Future<String?> login(int id) async{
    try{
      MAgencia mAgencia = await _cAgencia.consultar(id);
      _agencia = mAgencia;
      notifyListeners();
    } on ReachError catch(e) {
      return e.errMsg();
    } on EmptyError catch(e) {
      return e.errMsg();
    } catch(e){
      return e.toString();
    }
  }

  void logout() async{
    _agencia = null;
    notifyListeners();
  }
}