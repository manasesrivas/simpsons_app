import 'package:shared_preferences/shared_preferences.dart';

Future<void> guardarUsuario(String nombre) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('usuario', nombre);
}

Future<String?> obtenerUsuario() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('usuario');
}