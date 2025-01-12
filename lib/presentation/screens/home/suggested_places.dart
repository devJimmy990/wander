import 'package:flutter/material.dart';
import 'package:wander/core/user_credential.dart';
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
              governorate: places[index].governorate),
        );
      },
      itemCount: places.length,
    );
  }
}

class SuggestedCard extends StatefulWidget {
  final Item item;
  const SuggestedCard({super.key, required this.item});

  @override
  State<SuggestedCard> createState() => _SuggestedCardState();
}

class _SuggestedCardState extends State<SuggestedCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite =
        UserCredential.getInstance().isItemAddedBefore(id: widget.item.id);
  }

  void toggleFavorite({required Item item}) {
    if (isFavorite) {
      UserCredential.getInstance().removeFromFav(id: item.id);
    } else {
      UserCredential.getInstance().addToFav(item: item);
    }
    setState(() => isFavorite = !isFavorite);
  }

  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage(widget.item.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.item.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.item.governorate,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () => toggleFavorite(item: widget.item),
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,        //to toggle color of icon
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
