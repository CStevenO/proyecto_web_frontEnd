import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_web_frontend/controladores/agencia_provider.dart';
import 'package:proyecto_web_frontend/modelos/model_agencia.dart';

class Login extends StatefulWidget{
  const Login({Key? key}):super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _idNit = TextEditingController();
  final _nombre = TextEditingController();
  final _telefono = TextEditingController();
  final _direccion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final agenciaProvider = Provider.of<AgenciaManager>(context,listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(46.0),
          child: Center(
            child: SizedBox(
              width: 600,
              child: Card(
                elevation: 15.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      //Center(child: Text('Ingreso de Agencia',style: Theme.of(context).textTheme.headline2)),
                      Column(
                        children: [
                          //Campo de NIT
                          TextField(
                            controller: _idNit,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.account_balance,color: Colors.white),
                              border: UnderlineInputBorder(),
                              labelText: 'NIT',
                              hintText: 'Introduzca el NIT',
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.black38
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          //Campo de Nombre
                          TextField(
                            controller: _nombre,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.business,color: Colors.white),
                              border: UnderlineInputBorder(),
                              labelText: 'Nombre',
                              hintText: 'Introduzca el nombre',
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.black38
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          //Campo de Telefono
                          TextField(
                            controller: _telefono,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.phone,color: Colors.white),
                              border: UnderlineInputBorder(),
                              labelText: 'Telefono',
                              hintText: 'Introduzca el Telefono',
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.black38
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          //Campo de Direccion
                          TextField(
                            controller: _direccion,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.map,color: Colors.white),
                              border: UnderlineInputBorder(),
                              labelText: 'Dirección',
                              hintText: 'Introduzca la Dirección',
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.black38
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                          const SizedBox(height: 35),
                          Row(
                            children: [
                              Expanded(child: loginButton(context, agenciaProvider)),
                              const SizedBox(width: 15),
                              Expanded(child: signupButton(context,
                                agenciaProvider,
                                )
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
  Widget signupButton(BuildContext context, AgenciaManager magAgencia){
    return ElevatedButton(
      onPressed: () async{
        String idAgencia = _idNit.text;
        String direccion = _direccion.text;
        String telefono = _telefono.text;
        String nombre= _nombre.text;
        if(idAgencia != "" && direccion != "" && telefono != "" && nombre != "") {
          MAgencia agencia = MAgencia(
            idAgencia: int.tryParse(idAgencia)!,
            agNombre: nombre,
            agTelefono: telefono,
            agDireccion: direccion
          );
          String? mss = await magAgencia.signup(agencia);
          if (mss != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(mss)
                )
            );
          }
        } else{
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Por favor llenar todo para registrarse')
              )
          );
        }
      },
      style: ButtonStyle(
          side: MaterialStateProperty.all(const BorderSide(color: Colors.blue,width: 3)),
          backgroundColor: MaterialStateProperty.all(Colors.blue.shade100),
          overlayColor: MaterialStateProperty.all(Colors.blueGrey),
          elevation: MaterialStateProperty.all(15.0),
          padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )
          ),
          animationDuration: const Duration(milliseconds: 500),
          maximumSize: MaterialStateProperty.all(const Size(200.0,50.0)),
          minimumSize: MaterialStateProperty.all(const Size(105.0,40.0))
      ),
      autofocus: false,
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Text('Registrarse',
          style: GoogleFonts.getFont(
            'Roboto',
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Colors.blue,
          ),
        ),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

  Widget loginButton(BuildContext context, AgenciaManager magAgencia){
    return ElevatedButton(
      onPressed: () async{
        String idAgencia = _idNit.text;
        if(idAgencia != "") {
          int? id = int.tryParse(idAgencia);
          String? mss = await magAgencia.login(id!);
          if (mss != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(mss)
                )
            );
          }
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Ingrese el Nit para Ingresar')
              )
          );
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          overlayColor: MaterialStateProperty.all(Colors.blueGrey),
          elevation: MaterialStateProperty.all(15.0),
          padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )
          ),
          animationDuration: const Duration(milliseconds: 500),
          maximumSize: MaterialStateProperty.all(const Size(200.0,50.0)),
          minimumSize: MaterialStateProperty.all(const Size(105.0,40.0))
      ),
      autofocus: false,
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Text('Iniciar Sesión',
          style: GoogleFonts.getFont(
            'Roboto',
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}