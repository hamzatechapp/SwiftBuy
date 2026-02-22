import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:swiftbuy/Models/productmodel.dart';
import 'package:swiftbuy/Services/getproductapiservies.dart';

class Productsprovider with ChangeNotifier {

 bool _ISloading =  false ;
  List<Productmodel> _myproducts = [];

bool get isloading => _ISloading ;
 List<Productmodel> get myproducts => _myproducts;
  Future<void> getallapidata() async {
if(_myproducts.isNotEmpty){
  return ;

}
_ISloading = true;
notifyListeners();


    try{
_myproducts= await Apiservies().fectApiData();

    }
    catch (e) {
throw 'errer a gaya $e';


    }
    finally{

      _ISloading = false ;
        notifyListeners();

    }

  }












}