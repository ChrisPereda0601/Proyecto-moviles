// import 'dart:convert';

// import 'package:equatable/equatable.dart';

class Product {
  final String name;
  final double price;
  int quantity;
  final String description;
  final String image;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.image,
    // required this.qr,
  });

//Tal vez lo usemos
  factory Product.fromMap(Map<String, dynamic> data) => Product(
        name: data['name'] as String,
        price: data['name'] as double,
        quantity: data['name'] as int,
        description: data['name'] as String,
        image: data['name'] as String,
      );
  Map<String, dynamic> toMap() => {
        'name': name,
        'price': price,
        'quantity': quantity,
        'description': description,
        'image': image,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Amphibian].
  // factory Amphibian.fromJson(String data) {
  // 	return Amphibian.fromMap(json.decode(data) as Map<String, dynamic>);
  // }
  // /// `dart:convert`
  // ///
  // /// Converts [Amphibian] to a JSON string.
  // String toJson() => json.encode(toMap());

  // Amphibian copyWith({
  // 	String? name,
  // 	String? type,
  // 	String? description,
  // }) {
  // 	return Amphibian(
  // 		name: name ?? this.name,
  // 		type: type ?? this.type,
  // 		description: description ?? this.description,
  // 	);
}
