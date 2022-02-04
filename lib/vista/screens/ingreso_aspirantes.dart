import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_web_frontend/controladores/controller_oferta.dart';
import 'package:proyecto_web_frontend/modelos/model_oferta.dart';
import 'package:proyecto_web_frontend/vista/screens/aspirantes_concept.dart';

class IngresoAspirantes extends StatelessWidget{
  const IngresoAspirantes({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: COferta().habilitados(),
      builder: (context, AsyncSnapshot<List<MOferta>> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return AspirantesConcept(ofertas: snapshot.data ?? []);
        }else{
          return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}