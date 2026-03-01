import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:swiftbuy/Models/productmodel.dart';
import 'package:swiftbuy/Services/getproductapiservies.dart';
enum mystate {loading,errormassge,sucess}
class Productsprovider with ChangeNotifier {
  mystate _states = mystate.sucess;
  mystate get states => _states;
  String  errormassage = "" ;
  List<Productmodel> _myproducts = [];
  List<Productmodel> flitterdata = [];
  String selectcatagory = "all";
  TextEditingController searchbarcontroller = TextEditingController();
  List<String> catagory = ['all',
    "men's clothing",
    "jewelery",
    "electronics",
    "women's clothing"];

  List<Productmodel>  get  myproducts  {
   if(searchbarcontroller.text.isEmpty&& selectcatagory == 'all')
    {
      return
        _myproducts;}
else {
  return
      flitterdata;}
  }

  Future<void> getallapidata() async {
var box = Hive.box('openbigbox');
  var chitsavewaladata = box.get('chitsavedata');
if (chitsavewaladata != null) {
  print("Hive mein data mila: ${chitsavewaladata.length}");
  final rawdata = (chitsavewaladata as List);
  _myproducts =
      rawdata.map((e) => Productmodel.frommap(Map<String,dynamic>.from((e))
      )).toList();

  _states = mystate.sucess;
  notifyListeners();
}
else{
  _states = mystate.loading;
  notifyListeners();
}





    try{
List<Productmodel> objectapi  = await Apiservies().fectApiData();

List<Map<String,dynamic>> mymapforhive = objectapi.map((e) => e.tomap()).toList();

_myproducts = objectapi;


box.put('chitsavedata',mymapforhive );

_states = mystate.sucess;
    }
    catch (e) {
  errormassage = "masla ha bahiii ";
  _states = mystate.errormassge;

    }
    finally{


        notifyListeners();

    }

  }


  void flitter( String query){
    if(query.isEmpty)
    {
      flitterdata =[];
    }
   else {
      flitterdata = _myproducts.where((product) {
        return
          product.title!.toLowerCase().contains(query.toLowerCase());
      }


      ).toList();
    }
   notifyListeners();
  }

  void flittercatagory( String catagorybyuser){

selectcatagory = catagorybyuser;
if (catagorybyuser == "all") {
  flitterdata = [];
}
else{
  flitterdata = _myproducts.where((p)  {
    return
    p.category!.toLowerCase() == catagorybyuser.toLowerCase();

  }   ).toList();


}
notifyListeners();
  }
}