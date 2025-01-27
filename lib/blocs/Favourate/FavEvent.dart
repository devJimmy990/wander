import 'package:equatable/equatable.dart';
import 'package:wander/data/model/item.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddToFavorites extends FavoriteEvent {
  final Item item;

  const AddToFavorites(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveFromFavorites extends FavoriteEvent {
  final String id;

  const RemoveFromFavorites(this.id);

  @override
  List<Object> get props => [id];
}