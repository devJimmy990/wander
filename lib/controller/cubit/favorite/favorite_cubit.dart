import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/favorite/favorite_state.dart';
import 'package:wander/data/model/item.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final List<Item> _favorites = [];
  final FirebaseFirestore firestore;

  FavoriteCubit({FirebaseFirestore? firestoreInstance})
      : firestore = firestoreInstance ?? FirebaseFirestore.instance,
        super(FavoriteInitial());

  Future<void> onAddToFavorites(Item item, String userId) async {
    if (!_favorites.contains(item)) {
      _favorites.add(item);
      await firestore
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
/// will remove item from favorite page and fire store.
  Future<void> onRemoveFromFavorites(Item item, String userId,String id) async{
    int index = _favorites.indexWhere((item) => item.id == id);
    if (index != -1) {
      _favorites.removeAt(index);
      await firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(item.title)
          .delete();
      emit(FavoriteLoaded(_favorites));
    }
  }
}
