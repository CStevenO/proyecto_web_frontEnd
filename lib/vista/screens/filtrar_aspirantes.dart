import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_web_frontend/controladores/controller_aspirante.dart';
import 'package:proyecto_web_frontend/modelos/model_aspirante.dart';
import 'package:proyecto_web_frontend/modelos/model_profesion.dart';

class FiltrarAspirantes extends StatefulWidget{
  const FiltrarAspirantes({Key? key}):super(key: key);

  @override
  State<FiltrarAspirantes> createState() => _FiltrarAspirantesState();
}

class _FiltrarAspirantesState extends State<FiltrarAspirantes> {
  late List<bool> _isOpen;
  List<MAspirante> aspirantesLetra = [];
  late MAspirante aspiranteMayor;
  int _profesion = -1;
  List<MAspirante> aspirantesProf = [];
  int _genero = -1;
  List<MAspirante> aspirantesProfGen = [];

  void actualizarProf(int aspProfesion)async{
    List<MAspirante> aspirantes = await CAspirante().porProfesion(aspProfesion);
    setState(() {
      aspirantesProf = aspirantes;
      _profesion = aspProfesion;
    });
  }

  @override
  void initState() {
    _isOpen = [false,false,false,false,false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: ExpansionPanelList(
          dividerColor: Colors.blue[800],
          children: [
            buildFiltroLetra(context),
            buildFiltroMayor(context),
            buildFiltroGenPro(context),
            buildFiltroProfesion(context),
            buildReporteGenPro(context),
          ],
          expansionCallback: (i,isOpen)=>setState(() {
            _isOpen[i] = !isOpen;
          }),
          animationDuration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }

  ExpansionPanel buildFiltroLetra(BuildContext context){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return const Text('Filtrar por la primera letra del nombre');
      },
      body: buildLetra(context),
      isExpanded: _isOpen[0],
      canTapOnHeader: true,
    );
  }

  Widget buildLetra(BuildContext context){
    final _letra = TextEditingController();

    Future<void> actualizacion(List<MAspirante> aspis)async {
      setState(() {
        aspirantesLetra = aspis;
      });
    }

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cantidad de aspirantes',style: GoogleFonts.lato(fontSize: 28.0)),
          const Divider(thickness: 5,height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Letra: ',style: GoogleFonts.lato(fontSize: 18.0)),
              const SizedBox(width: 30),
              SizedBox(
                width: 200,
                child: TextField(
                  maxLength: 1,
                  controller: _letra,
                  decoration: const InputDecoration(
                      hintText: 'Ej. K o S',
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
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: ()async{
                  if(_letra.text != "") {
                    List<MAspirante> aspis = await CAspirante().obtenerPorLetra(_letra.text);
                    await actualizacion(aspis);
                  }
                },
                child: const Icon(Icons.done)
              )
            ],
          ),
          Center(child: Text('Total: ' + aspirantesLetra.length.toString(),style: GoogleFonts.lato(fontSize: 18.0))),
        ],
      ),
    );
  }

  ExpansionPanel buildFiltroMayor(BuildContext context){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return const Text('Obtener el Aspirante Mayor');
      },
      body: FutureBuilder(
        future: CAspirante().obtenerMayor(),
        builder: (context, AsyncSnapshot<MAspirante> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return buildaspiranteMayor(context,snapshot.data ?? MAspirante.init(id: 0));
          }else{
            return const CircularProgressIndicator.adaptive();
          }
        }
      ),
      isExpanded: _isOpen[1],
      canTapOnHeader: true,
    );
  }

  Widget buildaspiranteMayor(BuildContext context, MAspirante? mayor){
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Aspirante Mayor',style: GoogleFonts.lato(fontSize: 28.0)),
          const Divider(thickness: 5,height: 30),
          Center(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('IdAspirante')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Edad')),
                DataColumn(label: Text('Genero')),
                DataColumn(label: Text('IdProfesión')),
                DataColumn(label: Text('IdAgencia')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text(mayor!.id.toString())),
                  DataCell(Text(mayor.asNombre.toString())),
                  DataCell(Text(mayor.asEdad.toString())),
                  DataCell(Text(mayor.asGenero.toString())),
                  DataCell(Text(mayor.profesion!.idProfesion.toString())),
                  DataCell(Text(mayor.agencia!.idAgencia.toString())),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  ExpansionPanel buildFiltroGenPro(BuildContext context){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return const Text('Filtrar por Genero y Profesión');
      },
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Aspirantes por Profesión y Genero',style: GoogleFonts.lato(fontSize: 28.0)),
            const Divider(thickness: 5,height: 30),
            Text('Profesion',style: GoogleFonts.lato(fontSize: 18.0)),
            Center(child: buildProfesionField(entidad: false)),
            const SizedBox(height: 15),
            Text('Genero',style: GoogleFonts.lato(fontSize: 18.0)),
            Center(child: buildGeneroField()),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: ()async{
                  if(_profesion != -1 && _genero != -1){
                    List<MAspirante> aspirantes = await CAspirante().obtenerPorGeneroProfesion(
                        GeneroPersona.values[_genero].name,
                        ProfesionsTypes.values[_profesion]
                    );
                    setState(() {
                      aspirantesProfGen = aspirantes;
                      _profesion = -1;
                      _genero = -1;
                    });
                  }
                }, child: const Icon(Icons.done),
              ),
            ),
            Center(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('IdAspirante')),
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Edad')),
                  DataColumn(label: Text('Genero')),
                  DataColumn(label: Text('IdProfesión')),
                  DataColumn(label: Text('IdAgencia')),
                ],
                rows: aspirantesProfGen.map(
                  (asp) => DataRow(
                    cells: asp.toList().map(
                        (value) => DataCell(Text(value))
                    ).toList()
                  )
                ).toList()
              ),
            )
          ],
        ),
      ),
      isExpanded: _isOpen[2],
      canTapOnHeader: true,
    );
  }

  Widget buildGeneroField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

  ExpansionPanel buildFiltroProfesion(BuildContext context){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return const Text('Filtrar por Profesión');
      },
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: 5,height: 30),
            Center(child: buildProfesionField()),
            Center(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('IdAspirante')),
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Edad')),
                  DataColumn(label: Text('Genero')),
                  DataColumn(label: Text('IdProfesión')),
                  DataColumn(label: Text('IdAgencia')),
                ],
                rows: aspirantesProf.map(
                    (asp) => DataRow(
                        cells: asp.toList().map(
                                (value) => DataCell(Text(value))
                        ).toList()
                    )
                ).toList()
              ),
            ),
          ],
        ),
      ),
      isExpanded: _isOpen[3],
      canTapOnHeader: true,
    );
  }

  Widget buildProfesionField({bool entidad = true}){
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
              onSelected: (selected)async{
                if(entidad){
                  actualizarProf(ProfesionsTypes.Abogado.index);
                }else {
                  setState(() {
                    _profesion = ProfesionsTypes.Abogado.index;
                  });
                }
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
                if(entidad){
                  actualizarProf(ProfesionsTypes.Ingenieria_de_Sistemas.index);
                }else {
                  setState(() {
                    _profesion = ProfesionsTypes.Ingenieria_de_Sistemas.index;
                  });
                }
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
                if(entidad){
                  actualizarProf(ProfesionsTypes.Administracion_de_Empresas.index);
                }else {
                  setState(() {
                    _profesion = ProfesionsTypes.Administracion_de_Empresas.index;
                  });
                }
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
                if(entidad){
                  actualizarProf(ProfesionsTypes.Psicologia.index);
                }else {
                  setState(() {
                    _profesion = ProfesionsTypes.Psicologia.index;
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  ExpansionPanel buildReporteGenPro(BuildContext context){
    return ExpansionPanel(
      headerBuilder: (context, isOpen){
        return const Text('Reporte de Profesiones y Generos');
      },
      body: FutureBuilder(
          future: CAspirante().listar(),
          builder: (context, AsyncSnapshot<List<MAspirante>> snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return reporteView(context,snapshot.data ?? []);
            }else{
              return const CircularProgressIndicator.adaptive();
            }
          }
      ),
      isExpanded: _isOpen[4],
      canTapOnHeader: true,
    );
  }

  String cantGenero(List<MAspirante> aspirantes,String gen){
    List<bool> fem = aspirantes.map((e) => e.asGenero?.toUpperCase() == gen).toList();
    fem.removeWhere((element) => element == false);
    return fem.length.toString();
  }

  String cantProfesion(List<MAspirante> aspirantes,int pro){
    List<bool> ab = aspirantes.map((e) => e.profesion?.idProfesion == pro).toList();
    ab.removeWhere((element) => element == false);
    return ab.length.toString();
  }

  Widget reporteView(BuildContext context, List<MAspirante> aspirantes){
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(thickness: 5,height: 30),
          Center(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Femenino')),
                DataColumn(label: Text('Masculino')),
                DataColumn(label: Text('Otro')),
                DataColumn(label: Text('Abogados')),
                DataColumn(label: Text('Ingenieros')),
                DataColumn(label: Text('Administradores')),
                DataColumn(label: Text('Psicólogos')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text(cantGenero(aspirantes, "F"))),
                  DataCell(Text(cantGenero(aspirantes, 'M'))),
                  DataCell(Text(cantGenero(aspirantes, 'O'))),
                  DataCell(Text(cantProfesion(aspirantes, 1))),
                  DataCell(Text(cantProfesion(aspirantes, 2))),
                  DataCell(Text(cantProfesion(aspirantes, 3))),
                  DataCell(Text(cantProfesion(aspirantes, 4))),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}