import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_web_frontend/app_theme.dart';
import 'package:proyecto_web_frontend/controladores/agencia_provider.dart';
import 'package:proyecto_web_frontend/vista/screens/home.dart';
import 'package:proyecto_web_frontend/vista/screens/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.dark();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AgenciaManager>(
          lazy: false,
          create: (_) => AgenciaManager(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        title: 'Agencia',
        home: Consumer<AgenciaManager>(
          builder: (context, agenciaManager, child){
            if(agenciaManager.isLoggedIn()){
              return const Home();
            }else{
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
