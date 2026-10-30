import 'package:flutter/material.dart';
import 'package:tercer_examen/models/personaje.dart';
import 'package:tercer_examen/services/apiSimpsonService.dart';
import 'package:tercer_examen/notifers/favoritosNofifier.dart';
import 'package:tercer_examen/utils/user.dart';
import 'package:tercer_examen/utils/utils.dart';
import 'package:provider/provider.dart';

class PersonajePage extends StatefulWidget{
  final int personajeId;
  const PersonajePage({super.key, required this.personajeId});

  @override
  State<PersonajePage> createState() => _PersonajePageState();
}

class _PersonajePageState extends State<PersonajePage>{

  final ApiSimpsonService _apiSimpsonService = ApiSimpsonService();

  late Future<Personaje> _personaje;

  bool _favorito = false;

  @override
  void initState(){
    super.initState();
    _personaje = _apiSimpsonService.obtenerPersonaje(widget.personajeId);
    _revisarFavorito(widget.personajeId);
  }


  void _recargar(){
    setState(() {
      _personaje = _apiSimpsonService.obtenerPersonaje(widget.personajeId);
    });
  }

  Future<void> _revisarFavorito(int id) async{
    final esFav = context.read<FavoritosProviders>().esFavorito(widget.personajeId);
    setState(() {
      _favorito = esFav;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personaje'),
      ),
      body: Center(child: _contenido())
    );
  }

  Widget _contenido(){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder(
        future: _personaje,
        builder: builder
        )
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot<Personaje> snapshot){
    if(snapshot.connectionState == ConnectionState.waiting){
      return const Center(
        child: CircularProgressIndicator()
      );
    }

    if(snapshot.hasError){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Ocurrió un error.'),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: _recargar, child: const Text('Reintentar'))
        ],
      );
    }

    final personaje = snapshot.data!;

    return Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: button_favorito(context)
          ),
          Image.network(
            personaje.imagenUrl,
            width: 200,
            height: 200,
            fit: BoxFit.contain
          ),
          SizedBox(height: 20,),
          Text(personaje.nombre,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          Text(personaje.ocupacion),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1, color: Colors.grey
                  ),
                ),
                child: Text(
                  'Edad: ${personaje.edad}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(width: 30,),
              Container(
                padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: (personaje.estado == 'Alive')? const Color.fromARGB(255, 222, 255, 223): Colors.red,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 1, color: Colors.grey
                  )
                ),
                child: Text(
                  personaje.estado,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 31, 97, 33)
                  ),
                ),
              )
            ],
          )
        ],
      );
  }
  
  Widget button_favorito(BuildContext context){
    final id = widget.personajeId;

    final esFav = context.watch<FavoritosProviders>().esFavorito(id);
    final iconButton = IconButton(
      icon: (esFav) ? Icon(Icons.favorite_sharp): Icon(Icons.favorite_outline),
      onPressed: () async{
        
        if(_favorito){
          await quitarFavorito(id);
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Personaje eliminado de favoritos'),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 1),
            )
            );

        }else{
          final usuario = await obtenerUsuario();
          await agregarFavorito(id, usuario ?? '');
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Personaje agregado a favoritos'),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 1),
            )
            );
        }
        if(!mounted) return;
        context.read<FavoritosProviders>().toggle(id);
        setState(() {
          _favorito = !_favorito;
        });
      },
    );
    return iconButton;
  }
}