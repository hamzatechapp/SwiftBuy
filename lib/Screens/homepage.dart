import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftbuy/Models/productmodel.dart';
import 'package:swiftbuy/Providers/ProductsProvider.dart';
class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context)

  {   final myprovider =   context.watch<Productsprovider>();
    return Scaffold(body: Column(children: [


      FutureBuilder(future: Provider.of<Productsprovider>(context,listen: false).getallapidata(),
          builder: (context,snapshot) {




            if (myprovider.isloading) {
              return Center(child: CircularProgressIndicator(),
              );
            }




        return ListView.builder(
          itemCount: myprovider.myproducts.length,
itemBuilder: (context,index)
{






}





        );







      })






    ],),) ;
  }
}
