import 'package:flutter/material.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/Cart/cart_screen.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final List<List<dynamic>> drawerItems = [
    [Icons.home_outlined, "Home", HomeScreen()],
    [Icons.shopping_bag_outlined, "Review Cart", CartScreen()],
    [Icons.person_outline, "Profile", ProfileScreen()],
    [Icons.notifications_outlined, "Notification"],
    [Icons.star_border, "Rating & Reviews"],
    [Icons.favorite_border, "Wishlist"],
    [Icons.note_add_outlined, "Raise a Complaint"],
    [Icons.question_answer_outlined, "FAQs"]
  ];

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUserData().then((item) {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;
    final userName = user.userName!.split(' ');
    // if (isLoading) {
    //   return ;
    // }
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.surface,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DrawerHeader(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 43,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(user.userImage!),
                          // backgroundColor: Colors.red,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.surface),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            userName[0],
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.surface),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    itemCount: drawerItems.length,
                    itemBuilder: (context, index) {
                      IconData icon = drawerItems[index][0];
                      // print(index);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => drawerItems[index][2]));
                          },
                          child: Row(
                            children: [
                              Icon(
                                icon,
                                size: 30,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                drawerItems[index][1],
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Contact Support',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Call Us: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                          Text(
                            '+91 997 125 XXXX',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Mail Us: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                          Text(
                            'test@testing.com',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
