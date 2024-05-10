import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String? name;
  String? imagePath;
  double? price;
  int? review;
  String? details;

  ProductModel(
      {this.id,
      this.name,
      this.imagePath,
      this.price,
      this.review,
      this.details});

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductModel(
      id: data?['id'],
      name: data?['name'],
      imagePath: data?['imagePath'],
      price: data?['price'],
      review: data?['review'],
      details: data?['details'],
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
      price: json['price'].toDouble(),
      review: json['review'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['imagePath'] = imagePath;
    data['price'] = price;
    data['review'] = review;
    data['details'] = details;
    return data;
  }
}
