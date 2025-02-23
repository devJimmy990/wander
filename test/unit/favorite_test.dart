import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:wander/controller/cubit/favorite/favorite_cubit.dart';
import 'package:wander/controller/cubit/favorite/favorite_state.dart';
import 'package:wander/data/model/item.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeFirebaseFirestore fakeFirestore;
  late FavoriteCubit favoriteCubit;
  const userId = "test_user";

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    favoriteCubit = FavoriteCubit(firestoreInstance: fakeFirestore);
  });

  tearDown(() async {
    favoriteCubit.close();
  });

  group('FavoriteCubit Tests', () {
    test('should start with FavoriteInitial state', () {
      expect(favoriteCubit.state, isA<FavoriteInitial>());
    });



    test('should remove an item from favorites and update Firestore', () async {
      final item = Item(id: "1", title: "Pyramids", image: "pyramids.png", governorate: "Giza");

      await favoriteCubit.onAddToFavorites(item, userId);
      await favoriteCubit.onRemoveFromFavorites(item, userId, item.id);

      expect(favoriteCubit.state, isA<FavoriteLoaded>());
      final state = favoriteCubit.state as FavoriteLoaded;
      expect(state.favorites.contains(item), isFalse);

      // Verify Firestore Data
      final snapshot = await fakeFirestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(item.id)
          .get();
      expect(snapshot.exists, isFalse);
    });

    test('should fetch favorite items from Firestore', () async {
      final item1 = Item(id: "1", title: "Pyramids", image: "pyramids.png", governorate: "Giza");
      final item2 = Item(id: "2", title: "Citadel", image: "citadel.png", governorate: "Cairo");

      await favoriteCubit.onAddToFavorites(item1, userId);
      await favoriteCubit.onAddToFavorites(item2, userId);



      expect(favoriteCubit.state, isA<FavoriteLoaded>());
      final state = favoriteCubit.state as FavoriteLoaded;
      expect(state.favorites.length, 2);
      expect(state.favorites.contains(item1), isTrue);
      expect(state.favorites.contains(item2), isTrue);
    });
  });
}
