import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/blocs/Favourate/FavBloc.dart';
import 'package:wander/blocs/Favourate/FavEvent.dart';
import 'package:wander/blocs/Favourate/FavState.dart';
import 'package:wander/data/model/item.dart';


class SuggestedPlaces extends StatelessWidget {
  final List<Item> places;
  const SuggestedPlaces({
    super.key,
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return SuggestedCard(
          item: Item(
            id: places[index].id,
            title: places[index].title,
            image: places[index].image,
            governorate: places[index].governorate,
          ),
        );
      },
      itemCount: places.length,
    );
  }
}

class SuggestedCard extends StatelessWidget {
  final Item item;
  const SuggestedCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        final isFavorite = state is FavoriteLoaded
            ? state.favorites.any((fav) => fav.id == item.id)
            : false;

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3,
          color: Color(0xFFf5ebe0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.governorate,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (isFavorite) {
                          context.read<FavoriteBloc>().add(RemoveFromFavorites(item.id));
                        } else {
                          context.read<FavoriteBloc>().add(AddToFavorites(item));
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}