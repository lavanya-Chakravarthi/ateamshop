import 'package:ateamtest/service/productservice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class productProvider extends ChangeNotifier{
  productProvider(){
    getProducts();
  }

  List? _products;

  get product=>_products;

//gets the product list from service page
  getProducts() async{
    try{
      _products=await Productservice().getProductList();
      print("---model $_products");
      notifyListeners();
    }catch(e){
      print("---error $e");
    }
  }

}