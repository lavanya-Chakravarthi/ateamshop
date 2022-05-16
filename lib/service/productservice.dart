import 'dart:convert';

import 'package:http/http.dart' as http;

class Productservice{
  List? productList;


  //Calls the api for products
  getProductList() async{
    try {
      var result = await http.get(
          Uri.parse("https://fakestoreapi.com/products/"), headers: {
        "Content-Type": "application/json",
      });
      if(result.statusCode == 200) {
        productList = jsonDecode(result.body);
      }else{
        productList=[];
      }
      return productList;
    }catch(e){
      print("----Service error $e---");
      return e.toString();
    }

  }
}