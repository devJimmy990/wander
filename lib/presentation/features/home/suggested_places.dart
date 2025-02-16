import 'package:flutter/material.dart';
import 'package:wander/core/routes.dart';
import 'package:wander/data/model/item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/controller/cubit/favorite/index.dart';
import 'package:wander/controller/cubit/user/user_cubit.dart';

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
    return BlocBuilder<FavoriteCubit, FavoriteState>(
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
                        if (context.read<UserCubit>().user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please login first.'),
                              action: SnackBarAction(
                                label: "Login",
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.login);
                                },
                              ),
                            ),
                          );
                        } else {
                          if (isFavorite) {
                            context
                                .read<FavoriteCubit>()
                                .onRemoveFromFavorites(item, context.read<UserCubit>().user!.id.toString(),item.id);
                          } else {
                            context
                                .read<FavoriteCubit>()
                                .onAddToFavorites(item, context.read<UserCubit>().user!.id.toString());
                          }
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
