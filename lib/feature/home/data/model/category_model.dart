import 'package:equatable/equatable.dart';
import 'package:mimi_shope/feature/home/data/model/coffee_model.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final List<CoffeeItemModel> product;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.product,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'] as String,
      product: (json['product'] as List)
          .map(
            (product) =>
                CoffeeItemModel.fromJson(product as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'product': product};
  }

  @override
  List<Object?> get props => [id, name, product];
}
