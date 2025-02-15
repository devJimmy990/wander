import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/favorite/favorite_state.dart';
import 'package:wander/data/model/item.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final List<Item> _favorites = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FavoriteCubit() : super(FavoriteInitial());

  Future<void> onAddToFavorites(Item item, String userId) async {
    if (!_favorites.contains(item)) {
      _favorites.add(item);
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(item.title)
          .set({
        'title': item.title,
        'governorate': item.governorate,
      });
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
