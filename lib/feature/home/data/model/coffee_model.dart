import 'package:equatable/equatable.dart';

class CoffeeItemModel extends Equatable {
  final int id;
  final String name;
  final String subtitle;
  final double price;
  final double rating;
  final String? image;

  const CoffeeItemModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.image,
  });

  factory CoffeeItemModel.fromJson(Map<String, dynamic> json) {
    return CoffeeItemModel(
      id: json['id'] as int,
      name: json['name'] as String,
      subtitle: json['subtitle'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'price': price,
      'rating': rating,
      'image': image,
    };
  }

  @override
  List<Object?> get props => [id, name, image, rating, subtitle, price];
}
