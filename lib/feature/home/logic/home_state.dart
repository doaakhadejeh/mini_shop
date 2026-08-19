import 'package:equatable/equatable.dart';
import 'package:mimi_shope/feature/home/data/model/category_model.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

sealed class HomeState extends Equatable {}

final class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

final class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

final class HomeSuccess extends HomeState {
  final List<CategoryModel> categories;
  final List<CoffeeItemModel> products;

  HomeSuccess({required this.categories, required this.products});

  @override
  List<Object?> get props => [categories, products];
}

final class HomeSearch extends HomeState {
  final List<CategoryModel> categories;
  final List<CoffeeItemModel> products;

  HomeSearch({required this.categories, required this.products});

  @override
  List<Object?> get props => [categories, products];
}

final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
  @override
  List<Object?> get props => [message];
}
