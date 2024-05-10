import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product_model.dart';

class ProductsViewModel {
  final List<ProductModel> products = [];
  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>?> getProducts() async {
    products.clear();
    final querySnapshot = await _db.collection("products").get();
    for (var docSnapshot in querySnapshot.docs) {
      print(docSnapshot.data());
      products.add(ProductModel.fromJson(docSnapshot.data()));
    }
    return products;
  }

  Future<void> deleteProduct(String productId) async{
    await _db.collection("products").doc(productId).delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }

}