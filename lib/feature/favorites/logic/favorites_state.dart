import 'package:equatable/equatable.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

sealed class FavoritesState extends Equatable {}

final class FavoritesInitial extends FavoritesState {
  @override
  List<Object?> get props => [];
}

final class FavoritesLoading extends FavoritesState {
  @override
  List<Object?> get props => [];
}

final class FavoritesSuccess extends FavoritesState {
  final List<CoffeeItemModel> products;

  FavoritesSuccess({required this.products});

  @override
  List<Object?> get props => [products];
}

final class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
  @override
  List<Object?> get props => [message];
}
