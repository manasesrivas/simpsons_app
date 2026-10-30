import 'package:flutter/foundation.dart';

class FavoritosProviders extends ChangeNotifier{
  final Set<int> _favoritos = {};

  Set<int> get favoritos => Set.unmodifiable(_favoritos);

  bool esFavorito(int id) => _favoritos.contains(id);

  void toggle(int id){
    if(!_favoritos.add(id)){
      _favoritos.remove(id);
    }
    notifyListeners();
  }

  void cargar(Set<int> ids){
    _favoritos
    ..clear()
    ..addAll(ids);
    notifyListeners();
  }

}