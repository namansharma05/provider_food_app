import 'package:flutter/material.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:food_app/screens/product/product_overview.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  void initState() {
    // TODO: implement initState
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.fetchHerbsProductData();
    productProvider.fetchFreshFruitsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Column(
      children: [
        herbsSeasonings(context, productProvider),
        freshFruits(context, productProvider),
      ],
    );
  }

  Widget herbsSeasonings(BuildContext context, productProvider) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Herbs Seasonings',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'view all',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: productProvider.herbsSeasonings.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          productProvider.setCurrentProduct(
                              productProvider.herbsSeasonings[index]);
                          // productProvider.setProductType("herbsSeasonings");
                          // productProvider.setProductId(index);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductOverview(),
                            ),
                          );
                          // print(productProvider.productType);
                          // print(productProvider.productId);
                        },
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                productProvider
                                    .herbsSeasonings[index].productImage,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productProvider
                                  .herbsSeasonings[index].productName,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              productProvider
                                  .herbsSeasonings[index].productPrice
                                  .toString(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                // First button-like container with text and icon
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryFixedDim, // Color of the container
                                      borderRadius: BorderRadius.circular(
                                          20), // Shape of the container
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              productProvider
                                                  .herbsSeasonings[index]
                                                  .productWeight,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const Icon(Icons.add,
                                              color: Colors.white),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget freshFruits(context, productProvider) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fresh Fruits',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'view all',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: productProvider.freshFruits.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          // productProvider.setProductType("freshFruits");
                          // productProvider.setProductId(index);
                          productProvider.setCurrentProduct(
                              productProvider.freshFruits[index]);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductOverview(),
                            ),
                          );
                          // print(productProvider.productType);
                          // print(productProvider.productId);
                        },
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                productProvider.freshFruits[index].productImage,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productProvider.freshFruits[index].productName,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              productProvider.freshFruits[index].productPrice
                                  .toString(),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                // First button-like container with text and icon
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryFixedDim, // Color of the container
                                      borderRadius: BorderRadius.circular(
                                          20), // Shape of the container
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              productProvider.freshFruits[index]
                                                  .productWeight,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const Icon(Icons.add,
                                              color: Colors.white),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
