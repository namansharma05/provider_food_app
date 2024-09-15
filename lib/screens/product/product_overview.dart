import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductOverview extends StatefulWidget {
  const ProductOverview({super.key});

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  Map<String, dynamic>? productDetails;
  bool _isLoading = true;
  Future<void> loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/product_details.json');

    final jsonResponse = json.decode(jsonString);
    print('inside loadJsonData');

    setState(() {
      print('inside loadJsonData setState');
      productDetails = jsonResponse;
      _isLoading = false;
      print(_isLoading);
      setState(() {});
      // print(_products!["count"]);
    });
  }

  final ScrollController _controller = ScrollController();
  bool _isButtonVisible = true;
  final GlobalKey _buttonKey = GlobalKey();
  double _buttonPosition = 0.0;

  void _findButtonPosition() {
    final RenderBox renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    setState(() {
      _buttonPosition = position.distance;
      print("button position is " + _buttonPosition.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('inside initstate');
    loadJsonData().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _findButtonPosition();
      });
    });
    // Initialize the listener for scroll events
    _controller.addListener(() {
      // print("button position = " + _buttonPosition.toString());
      // print("controller offset = " +
      //     (_controller.offset + 714.1835777).toString());
      if (_controller.offset + 770.1835777 >= _buttonPosition &&
          _isButtonVisible) {
        setState(() {
          _isButtonVisible = false;
        });
      } else if (_controller.offset + 770.1835777 < _buttonPosition &&
          !_isButtonVisible) {
        setState(() {
          _isButtonVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    // final productType = productProvider.productType;
    // final productId = productProvider.productId;
    final currentProduct = productProvider.currentProduct;

    final cartProvider = Provider.of<CartProvider>(context);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Product Overview',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 17),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                controller: _controller,
                scrollDirection: Axis.vertical,
                child: Container(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentProduct.productName.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          currentProduct.productPrice.toString(),
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                currentProduct.productImage.toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          currentProduct.productDescription.toString(),
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          key: _buttonKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(150, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryFixedDim,
                                ),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Wishlist',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(150, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryFixedDim,
                                ),
                                onPressed: () {
                                  print("add to cart button pressed");
                                  cartProvider.addCartItems(currentProduct);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_bag_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_isButtonVisible)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryFixedDim,
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Wishlist',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryFixedDim,
                          ),
                          onPressed: () {
                            print("stiky add to cart button pressed");
                            cartProvider.addCartItems(currentProduct);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Add to Cart',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
