import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftbuy/Models/productmodel.dart';
import 'package:swiftbuy/Providers/ProductsProvider.dart';
import 'package:swiftbuy/Screens/detail%20screen.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<Productsprovider>().getallapidata();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myprovider = context.watch<Productsprovider>();

    return Scaffold(
      backgroundColor: Colors.grey[50],

      // Simple Professional AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black87),
          onPressed: () {},
        ),
        title: Text(
          'SwiftBuy',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        children: [
          // Simple Search Bar
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: context.read<Productsprovider>().searchbarcontroller,
              onChanged: (value) {
                context.read<Productsprovider>().flitter(value);
              },
              decoration: InputDecoration(
                hintText: 'Search products',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),

          // Simple Categories
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 8),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: myprovider.catagory.length,
              itemBuilder: (context, index) {
                String catagory = myprovider.catagory[index];
                bool isselected = myprovider.selectcatagory == catagory;

                return GestureDetector(
                  onTap: () {
                    context.read<Productsprovider>().flittercatagory(catagory);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isselected ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isselected ? Colors.blue : Colors.grey[300]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        catagory,
                        style: TextStyle(
                          color: isselected ? Colors.white : Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Products Grid
          Expanded(
            child: switch (myprovider.states) {
              mystate.loading => Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
              mystate.errormassge => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Connection Error',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Please check your internet connection',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              mystate.sucess => GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: myprovider.myproducts.length,
                itemBuilder: (context, index) {
                  Productmodel product = myprovider.myproducts[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
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
                                          Icons.shopping_bag_outlined,
                                          size: 50,
                                          color: Colors.grey[400],
                                        );
                                      },
                                    ),
                                  ),
                                  // Rating
                                  if (product.rating != null)
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              '${product.rating?.rate ?? 0.0}',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
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
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title ?? 'No Title',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${product.price ?? 0.0}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Added to cart!'),
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            Icons.add_shopping_cart,
                                            size: 18,
                                            color: Colors.white,
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
