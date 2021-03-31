import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eAgric_admin/helpers/costants.dart';
import 'package:eAgric_admin/models/products.dart';

class ProductsServices {
  String collection = "Products";

  Future<List<ProductModel>> getAllProducts() async =>
      firebaseFiretore.collection(collection).get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });
}
