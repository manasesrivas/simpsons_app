import 'package:flutter/material.dart';
import 'package:tercer_examen/screens/personajesPage.dart';
import 'package:tercer_examen/utils/user.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  final _formKey = GlobalKey<FormState>();
  final _nombreUsuarioController = TextEditingController();
  
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    _nombreUsuarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Guarda tu nombre'),),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  Text(
                  '¡Bienvenido!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Ingresa tu nombre para guardar y consultar tus personajes favoritos de los simpsons',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _nombreUsuarioController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    hintText: 'Escribe tu nombre',
                    border: OutlineInputBorder(),
                  ),
                  validator: validation
                ),
                SizedBox(height: 50,),
                ElevatedButton(
                  onPressed: _onSubmitLogin,
                  child: const Text('Siguiente'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    elevation: 4
                  )
                )
              ],
            ),
          )
          
        )
      )
    );
  }

  String? validation(value){
    if(value == null || value.trim().isEmpty) return 'Es obligatorio un nombre';
    if(value.length < 4) return 'El nombre debe contener al menos 4 letras';

    return null;
  }

  Future<void> _onSubmitLogin()async{
    if(_formKey.currentState!.validate()){
      final nombreUsuario = _nombreUsuarioController.text;
      await guardarUsuario(nombreUsuario);
      Navigator.push(context, 
        MaterialPageRoute(
          builder: (context){
            return ListaPersonajesPage();
          }
        )
      );
    }
  }
  
}


