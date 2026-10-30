import 'package:flutter/material.dart';
import 'package:tercer_examen/notifers/favoritosNofifier.dart';
import 'package:tercer_examen/screens/register.dart';
import 'screens/personajesPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritosProviders(),
      child: const MainApp()
    )
  );
}

class MainApp extends StatelessWidget{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}
