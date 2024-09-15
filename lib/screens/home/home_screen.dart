import 'package:flutter/material.dart';
import 'package:food_app/screens/Cart/cart_screen.dart';
import 'package:food_app/widgets/product.dart';
import 'package:food_app/screens/home/side_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
        title: Text(
          'Home',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 17),
        ),
        actions: [
          CircleAvatar(
            radius: 12,
            child: Stack(
              children: [
                Positioned(
                  left: -12,
                  bottom: -12,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 17,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CircleAvatar(
              radius: 12,
              child: Stack(
                children: [
                  Positioned(
                    left: -12,
                    bottom: -12,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CartScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                        size: 17,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: SideDrawer(),
      body: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(
            10,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage('assets/allFood.jpeg'),
                        fit: BoxFit.cover),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          // color: Colors.blue,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 180.0),
                                child: Container(
                                  height: 40,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixedDim,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(35),
                                      bottomRight: Radius.circular(35),
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Vegi',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        shadows: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.green.shade900,
                                            offset: Offset(3, 3),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 40.0),
                                child: Text(
                                  '30% Off',
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.green[100],
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.green.shade900,
                                        offset: Offset(3, 3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                'On all vegetables products',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Product(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
