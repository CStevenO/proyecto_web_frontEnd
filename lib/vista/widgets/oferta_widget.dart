import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_web_frontend/modelos/model_oferta.dart';

class OfertaWidget extends StatelessWidget{
  MOferta oferta;
  Color? color;

  OfertaWidget({
    Key? key,
    required this.oferta,
    this.color = Colors.blue
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.topCenter,
      clipBehavior: Clip.antiAlias,
      child: Card(
        color: color == Colors.blue ? Colors.blue[800]: color,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(oferta.oNombre ?? '',style: GoogleFonts.lato(fontSize: 28.0)),
              Text(
                oferta.oDescripcion ?? '',
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Empieza: ' + DateFormat('yyyy-MM-dd').format(oferta.oFechaInicio ?? DateTime.now())),
                  const SizedBox(width: 25),
                  Text('Termina: ' + DateFormat('yyyy-MM-dd').format(oferta.oFechaFin ?? DateTime.now())),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
