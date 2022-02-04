import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_web_frontend/controladores/agencia_provider.dart';
import 'package:proyecto_web_frontend/controladores/controller_aspirante.dart';
import 'package:proyecto_web_frontend/controladores/controller_empleabilidad.dart';
import 'package:proyecto_web_frontend/exceptions/errors.dart';
import 'package:proyecto_web_frontend/modelos/model_aspirante.dart';
import 'package:proyecto_web_frontend/modelos/model_empleabilidad.dart';
import 'package:proyecto_web_frontend/modelos/model_oferta.dart';
import 'package:proyecto_web_frontend/modelos/model_profesion.dart';
import 'package:proyecto_web_frontend/vista/widgets/oferta_widget.dart';

class AspirantesConcept extends StatefulWidget{
  List<MOferta> ofertas;
  AspirantesConcept({Key? key,required this.ofertas}):super(key: key);

  @override
  State<AspirantesConcept> createState() => _AspirantesConceptState();
}

class _AspirantesConceptState extends State<AspirantesConcept> {
  final _id = TextEditingController();
  final _nombre = TextEditingController();
  MOferta? oferta = null;
  int _selectedOferta = -1;
  int _genero = -1;
  int _edad = 24;
  int _profesion = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: ListView(
          children: [
            Card(
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildNombre(context),
                    const SizedBox(height: 10),
                    buildDocumento(context),
                    const SizedBox(height: 10),
                    buildGeneroField(),
                    const SizedBox(height: 10),
                    buildEdadField(),
                    const SizedBox(height: 10),
                    buildProfesionField(),
                  ],
                ),
              ),
            ),
            const Divider(indent: 30,endIndent: 30,height: 100,thickness: 12),
            Text('Ofertas Disponibles',style:GoogleFonts.lato(fontSize: 28.0)),
            const SizedBox(height: 10),
            OfertaGridView(context),
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
              onPressed: () async{
                try {
                  final int? idAspi = int.tryParse(_id.text);
                  idAspi == null ? throw NotANumber():null;
                  oferta == null ? throw OfertNull():null;
                  MAspirante aspi = MAspirante(
                      id: idAspi,
                      asNombre: _nombre.text,
                      asGenero: GeneroPersona.values[_genero].name,
                      asEdad: _edad,
                      agencia: Provider.of<AgenciaManager>(context, listen: false).getAgencia,
                      profesion: MProfesion.init(idProfesion: ProfesionsTypes.values[_profesion].index)
                  );
                  MEmpleabilidad emple = MEmpleabilidad(eFecha: DateTime.now(), aspirante: MAspirante.init(id: aspi.id), oferta: MOferta.init(id: oferta?.id));
                  await CAspirante().crear(aspi);
                  await CEmpleabilidad().crear(emple);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Aspirante Creado con la Oferta ${oferta?.oNombre}')
                      )
                  );
                  setState(() {
                    _id.clear();
                    _nombre.clear();
                    oferta = null;
                    _selectedOferta = -1;
                    _genero = -1;
                    _edad = 24;
                    _profesion = -1;
                  });
                } on NotANumber catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(e.errMsg())
                      )
                  );
                } on OfertNull catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(e.errMsg())
                      )
                  );
                } catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Llena todos los espacios por favor')
                      )
                  );
                }
              },
              child: const Icon(Icons.done)
            )
          ],
        ),
        Text('Nombre',style: GoogleFonts.lato(fontSize: 28.0)),
        TextField(
          controller: _nombre,
          decoration: const InputDecoration(
              hintText: 'Ej. Carlos Steven Ortiz C...',
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

  Widget buildDocumento(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Documento',style: GoogleFonts.lato(fontSize: 28.0)),
        TextField(
          controller: _id,
          decoration: const InputDecoration(
              hintText: 'Ej. 1234567...',
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

  Widget buildGeneroField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Genero',style: GoogleFonts.lato(fontSize: 28.0)),
        Wrap(
          spacing: 30.0,
          children: [
            ChoiceChip(
              label: const Text(
                'Femenino',
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.blue[800],
              selected: _genero == GeneroPersona.F.index,
              onSelected: (selected){
                setState(() {
                  _genero = GeneroPersona.F.index;
                });
              },
            ),
            ChoiceChip(
              label: const Text(
                'Masculino',
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.blue[800],
              selected: _genero == GeneroPersona.M.index,
              onSelected: (selected){
                setState(() {
                  _genero = GeneroPersona.M.index;
                });
              },
            ),
            ChoiceChip(
              label: const Text(
                'Otro',
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.blue[800],
              selected: _genero == GeneroPersona.O.index,
              onSelected: (selected){
                setState(() {
                  _genero = GeneroPersona.O.index;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildEdadField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('Edad',style: GoogleFonts.lato(fontSize: 28.0)),
            const SizedBox(width: 25.0),
            Text(_edad.toInt().toString(),style: GoogleFonts.lato(fontSize: 18.0)),

          ],
        ),
        Slider(
          inactiveColor: Colors.grey.shade800.withOpacity(0.5),
          activeColor: Colors.blue[800],
          value: _edad.toDouble(),
          min: 16.0,
          max: 100.0,
          divisions: 100,
          label: _edad.toInt().toString(),
          onChanged: (double value){
            setState(() {
              _edad = value.toInt();
            });
          }
        ),
      ],
    );
  }

  Widget buildProfesionField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Profesion',style: GoogleFonts.lato(fontSize: 28.0)),
        Wrap(
          spacing: 30.0,
          children: [
            ChoiceChip(
              label: const Text(
                'Abogado',
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.blue[800],
              selected: _profesion == ProfesionsTypes.Abogado.index,
              onSelected: (selected){
                setState(() {
                  _profesion = ProfesionsTypes.Abogado.index;
                });
              },
            ),
            ChoiceChip(
              label: const Text(
                'Ingeniería de Sistemas',
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.blue[800],
              selected: _profesion == ProfesionsTypes.Ingenieria_de_Sistemas.index,
              onSelected: (selected){
                setState(() {
                  _profesion = ProfesionsTypes.Ingenieria_de_Sistemas.index;
                });
              },
            ),
            ChoiceChip(
              label: const Text(
                'Administración de empresas',
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.blue[800],
              selected: _profesion == ProfesionsTypes.Administracion_de_Empresas.index,
              onSelected: (selected){
                setState(() {
                  _profesion = ProfesionsTypes.Administracion_de_Empresas.index;
                });
              },
            ),
            ChoiceChip(
              label: const Text(
                'Psicóloga',
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.blue[800],
              selected: _profesion == ProfesionsTypes.Psicologia.index,
              onSelected: (selected){
                setState(() {
                  _profesion = ProfesionsTypes.Psicologia.index;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget OfertaGridView(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.ofertas.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index){
          final simpleOferta = widget.ofertas[index];
          return GestureDetector(
            onTap: (){
              setState(() {
                oferta = widget.ofertas[index];
                _selectedOferta = index;
              });
            },
            child: _selectedOferta != index ?
              OfertaWidget(oferta: simpleOferta): OfertaWidget(oferta: simpleOferta,color: Colors.indigo)
          );
        }
      ),
    );
  }
}