import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/blocs/Favourate/FavEvent.dart';
import 'package:wander/blocs/Favourate/FavState.dart';
import 'package:wander/data/model/item.dart';


class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
  }

  final List<Item> _favorites = [];

  void _onAddToFavorites(AddToFavorites event, Emitter<FavoriteState> emit) {
    if (!_favorites.contains(event.item)) {
      _favorites.add(event.item);
    }
    emit(FavoriteLoaded(List.from(_favorites)));
  }

  void _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<FavoriteState> emit) {
    _favorites.removeWhere((item) => item.id == event.id);
    emit(FavoriteLoaded(List.from(_favorites)));
  }
}