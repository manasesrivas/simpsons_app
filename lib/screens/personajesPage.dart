import 'package:flutter/material.dart';
import 'package:tercer_examen/notifers/favoritosNofifier.dart';
import 'package:tercer_examen/services/apiSimpsonService.dart';
import 'package:tercer_examen/utils/user.dart';
import 'package:tercer_examen/utils/utils.dart';
import '../models/personaje.dart';
import 'personajePage.dart';
import 'package:provider/provider.dart';

class ListaPersonajesPage extends StatefulWidget {
  const ListaPersonajesPage({super.key});
  
  @override
  State<ListaPersonajesPage> createState() => _ListaPersonajesPageState();
}

class _ListaPersonajesPageState extends State<ListaPersonajesPage> {

  final TextEditingController _personajeController = TextEditingController();
  final ApiSimpsonService _apiSimpsonService = ApiSimpsonService();

  List<Personaje>? _busqueda = null;

  late Future<List<Personaje>> _personajes;
  int _page = 1;
  @override
  void initState() {
    super.initState();
    _personajes = _apiSimpsonService.obtenerPersonajes(_page);
    _cargarFavoritos();
  }

  @override
  void dispose(){
    _personajeController.dispose();
    super.dispose();
  }

  Future<void> _recargar()async{
    _personajeController.clear();
    _busqueda = null;
    setState(() {
        _personajes = _apiSimpsonService.obtenerPersonajes(_page);
    });
  }

  Future<void> _cargarFavoritos() async {
    final usuario = await obtenerUsuario();
    final favoritos = await obtenerFavoritos(usuario??'');
    print(favoritos);
    if(!mounted) return;
    context.read<FavoritosProviders>().cargar(favoritos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _personajeController,
          onSubmitted: onSubmit,
        ),
      ),
      body: _contenido(),
    );
  }

  Widget _contenido() {
    final futureBuilder = 
      FutureBuilder(
        future: _personajes,
        builder: builder,
      );
    return RefreshIndicator(
      onRefresh: _recargar,
      child: futureBuilder
    );
  }

  Widget builder(BuildContext context, AsyncSnapshot snapshot){
    if(snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
    if(snapshot.hasError) return hasError(snapshot.error);

    final personajes = _busqueda ?? snapshot.data ?? [];

    if(personajes.isEmpty){
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Center(
            child: Text('Personaje no encontrado')
          )
        ],
        
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: personajes.length+1,
      itemBuilder: (context, i) {
        if(i == personajes.length) return paginacion();
        final p = personajes[i];
        return Card(
          child: ListTile(
            leading: Image.network(p.imagenUrl),
            title: Text(p.nombre),
            subtitle: Text(p.ocupacion),
            trailing: Icon(
              (context.watch<FavoritosProviders>().esFavorito(p.id))? Icons.favorite_sharp: Icons.favorite_outline
            ),
            onTap: (){
              Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context){
                    return PersonajePage(personajeId: p.id);
                  }
                )
              );
            },
          ),
        );
      },
    );
  }


  void onSubmit(String nombre)async{
    final per = await _personajes;
    final personajes = (nombre.isEmpty)? null: per
      .where(
        (personaje) => personaje.nombre.toLowerCase().contains(nombre.toLowerCase())
      ).toList();
    setState(() {
      _busqueda = personajes;
    });
  }

  Widget paginacion(){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: (_page > 1)?_de:null,
            icon: Icon(Icons.navigate_before),
            style: IconButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white
            )
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Text(_page.toString()),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ]
            ),
          ),
          IconButton(
            onPressed: (_page >= 60)?null: _in,
            icon: Icon(Icons.navigate_next),
            style: IconButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white
            )
          )
        ],
      )
    );
  }

  void _in(){
    if(_page >= 60) return;
    setState(() {
      _page++;
    });
    _recargar();
  }

  void _de(){
    if(_page <= 0 ) return;
    setState(() {
      _page--;
    });
    _recargar();
  }

  Widget hasError(Object? error){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ocurrió un error.'),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: _recargar, child: const Text('Reintentar')),
        ],
      ),
    );
  }
  
}