import 'package:flutter_test/flutter_test.dart';
import 'package:wander/controller/cubit/favorite/favorite_cubit.dart';
import 'package:wander/controller/cubit/favorite/favorite_state.dart';
import 'package:wander/data/model/item.dart';

void main() {
  group('FavoriteCubit Tests', () {
    late FavoriteCubit favoriteCubit;
    late Item sampleItem;

    setUp(() {
      favoriteCubit = FavoriteCubit();
      sampleItem = Item(id: '1', title: 'Pyramids', governorate: 'Cairo', image: 'assets/images/governorates/cairo.jpg');
    });

    test('Adding an item to favorites updates state', () {
      favoriteCubit.onAddToFavorites(sampleItem, "user123");
      expect(favoriteCubit.state, isA<FavoriteLoaded>());
    });
  });
}
