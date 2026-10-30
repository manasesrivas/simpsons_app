import 'package:dio/dio.dart';
import 'package:tercer_examen/models/personaje.dart';

class ApiSimpsonService{
  final Dio _dio;

  ApiSimpsonService(
    {
      Dio? dio
    }
  ): _dio = dio ?? Dio(
    BaseOptions(
      baseUrl: 'https://thesimpsonsapi.com'
    )
  );

  Future<List<Personaje>> obtenerPersonajes(int page) async{
    try{
      final response = await _dio.get('/api/characters',
      queryParameters: {'page': page});
      final personajes = response.data is Map ? response.data['results'] as List: response.data as List;
      
      
      return personajes.map(
        (e)=>Personaje.fromJson(e)).toList();
    }catch(_){
      rethrow;
    }
  }

  Future<Personaje> obtenerPersonaje(int id) async{
    try{
      final response = await _dio.get('/api/characters/${id}');
      return Personaje.fromJson(response.data);
    }catch(_){
      rethrow;
    }

  }

  Future<List<Personaje>> pagePersonaje(int page) async {
    try{
      final response = await _dio.get('/api/characters',
        queryParameters: {
          'page': page
        }
      );
      final personajes = response.data is Map ? response.data['results'] as List: response.data as List;
      
      return personajes.map(
        (e)=>Personaje.fromJson(e)).toList();
    }catch(_){
      rethrow;
    }
  }
  
}