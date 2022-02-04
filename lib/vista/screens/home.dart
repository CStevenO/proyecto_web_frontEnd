import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_web_frontend/controladores/agencia_provider.dart';

import 'crear_ofertas.dart';
import 'filtrar_aspirantes.dart';
import 'ingreso_aspirantes.dart';

class Home extends StatefulWidget{
  const Home({Key? key}):super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  late List<Widget> pages;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    pages = <Widget>[
      CrearOfertas(),
      const IngresoAspirantes(),
      const FiltrarAspirantes(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final agencia = Provider.of<AgenciaManager>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(agencia.getAgencia?.agNombre??''),
        actions: [
          buildCerrar(context)
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_outlined),
            label: 'Crear Ofertas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_1),
            label: 'Agregar Aspirantes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list_alt),
            label: 'Filtrar Aspirantes',
          ),
        ],
      ),
    );
  }
  Widget buildCerrar(BuildContext context){
    return SizedBox(
      child: GestureDetector(
        onTap: (){
          final agencia = Provider.of<AgenciaManager>(context,listen: false);
          agencia.logout();
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}