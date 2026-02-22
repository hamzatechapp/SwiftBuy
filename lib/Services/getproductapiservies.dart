import 'dart:convert';

import 'package:http/http.dart';
import 'package:swiftbuy/Models/productmodel.dart';

class Apiservies{

  Future<List<Productmodel>> fectApiData ()async
  {
try{
  final String url = "https://fakestoreapi.com/products";

final respone = await get(Uri.parse(url));
if(respone.statusCode==200)
  {
    List<dynamic> rawdata = jsonDecode(respone.body);
 List<Productmodel> products = rawdata.map((item) => Productmodel.frommap(item)).toList();
return products;
  }
else {
  throw 'errer${respone.statusCode}';
}

}
catch (e) {

  throw 'error $e';
}
  }
}