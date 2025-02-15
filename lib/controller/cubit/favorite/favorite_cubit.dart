import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/favorite/favorite_state.dart';
import 'package:wander/data/model/item.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final List<Item> _favorites = [];
  FavoriteCubit() : super(FavoriteInitial());

  void onAddToFavorites(Item item) {
    if (!_favorites.contains(item)) {
      _favorites.add(item);
      emit(FavoriteLoaded(_favorites));
    }
  }

  void onRemoveFromFavorites(String id) {
    int index = _favorites.indexWhere((item) => item.id == id);
    if (index != -1) {
      _favorites.removeAt(index);
      emit(FavoriteLoaded(_favorites));
    }
  }
}
