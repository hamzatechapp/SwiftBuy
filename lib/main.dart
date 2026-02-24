import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:swiftbuy/Providers/ProductsProvider.dart';
import 'package:swiftbuy/Screens/homepage.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('openbigbox');
  
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) =>  Productsprovider(),
      child:  MaterialApp(
        home: homescreen(),
      ),
    );



  }
}
