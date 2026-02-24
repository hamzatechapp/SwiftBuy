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
  void initState() {
    context.read<Productsprovider>().getallapidata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myprovider = context.watch<Productsprovider>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black54),
              onPressed: () {},
            ),
 SizedBox(width: 80,),
            Text(
              'SwiftBuy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.blue[800],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.blue[800]),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: switch (myprovider.states) {
              mystate.loading => Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
              mystate.errormassge => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Connection Error',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Please check your internet connection',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              mystate.sucess => GridView.builder(
                padding: EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: myprovider.myproducts.length,
                itemBuilder: (context, index) {
                  Productmodel product = myprovider.myproducts[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Container
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Image.network(
                                    product.image ?? '',
                                    height: 100,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stack) {
                                      return Icon(
                                        Icons.shopping_bag,
                                        size: 50,
                                        color: Colors.blue[300],
                                      );
                                    },
                                  ),
                                ),
                                // Rating Badge
                                if (product.rating != null)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            '${product.rating?.rate ?? 0.0}',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        // Product Details
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Text(
                                  product.title ?? 'No Title',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),

                                Spacer(),

                                // Price and Button
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${product.price ?? 0.0}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                    Material(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(8),
                                        onTap: () {
                                          // Add to cart
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text('Added to cart!'),
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          child: Icon(
                                            Icons.add_shopping_cart,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            },
          ),
        ],
      ),
    );
  }
}