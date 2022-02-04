import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_web_frontend/controladores/controller_oferta.dart';
import 'package:proyecto_web_frontend/modelos/model_oferta.dart';

class CrearOfertas extends StatefulWidget{
  CrearOfertas({Key? key}):super(key: key);

  @override
  State<CrearOfertas> createState() => _CrearOfertasState();
}

class _CrearOfertasState extends State<CrearOfertas> {
  DateTime _fechaInicial = DateTime.now();
  DateTime _fechaFinal = DateTime.now();
  final _descripcion = TextEditingController();
  final _nombre = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: ListView(
          children: [
            Center(child: Text('Crear Ofertas',style: GoogleFonts.lato(fontSize: 28.0))),
            const SizedBox(height: 35),
            Card(
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildNombre(context),
                    const SizedBox(height: 10),
                    buildDescription(context),
                    const SizedBox(height: 10),
                    buildDateField(context, 'Inicio'),
                    const SizedBox(height: 10),
                    buildDateField(context, 'Fin'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNombre(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: ()async{
                  MOferta ofer = MOferta(
                      oDescripcion: _descripcion.text,
                      oFechaInicio: _fechaInicial,
                      oFechaFin: _fechaFinal,
                      oNombre: _nombre.text
                  );
                  MOferta? newOfer = await COferta().crear(ofer);
                  if (newOfer != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Oferta creada: ' + (newOfer.oNombre ?? ''))
                        )
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al crear Oferta')
                        )
                    );
                  }
                  setState(() {
                    _fechaFinal = DateTime.now();
                    _fechaInicial = DateTime.now();
                    _nombre.clear();
                    _descripcion.clear();
                  });
                },
                child: const Icon(Icons.done)
            )
          ],
        ),
        Text('Nombre',style: GoogleFonts.lato(fontSize: 28.0)),
        TextField(
          controller: _nombre,
          decoration: const InputDecoration(
              hintText: 'Ej. Se Solicita Ingeniero...',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38)
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38)
              )
          ),
        ),
      ],
    );
  }

  Widget buildDescription(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Descripción',style: GoogleFonts.lato(fontSize: 28.0)),
        TextField(
          controller: _descripcion,
          decoration: const InputDecoration(
              hintText: 'Ej. Oferta para Ingeniero de sistemas...',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38)
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38)
              )
          ),
        ),
      ],
    );
  }

  Widget buildDateField(BuildContext context, String concepto){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Fecha' + concepto, style: GoogleFonts.lato(fontSize: 28.0)),
            TextButton(
              child: const Text('Seleccionar'),
              onPressed: () async{
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: DateTime(currentDate.month - 1),
                    lastDate: DateTime(currentDate.year + 5)
                );
                setState(() {
                  if(selectedDate != null){
                    if(concepto == 'Inicio'){
                      _fechaInicial = selectedDate;
                    }else{
                      _fechaFinal = selectedDate;
                    }
                  }
                });
              },
            ),
          ],
        ),
        Text(DateFormat('yyyy-MM-dd').format(concepto == 'Inicio'? _fechaInicial:_fechaFinal)),
      ],
    );
  }
}