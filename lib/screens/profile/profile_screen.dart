import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/home/side_drawer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  final List<List<dynamic>> tileItems = [
    [Icons.shopping_bag_outlined, "My Orders"],
    [Icons.location_on_outlined, "My Delivery Address"],
    [Icons.person_outline, "Refer A friend"],
    [Icons.file_copy_outlined, "Terms & Conditions"],
    [Icons.policy_outlined, "Privacy Policy"],
    [Icons.add_chart_outlined, "About"],
    [Icons.exit_to_app_outlined, "Log Out"],
  ];

  @override
  void initState() {
    // TODO: implement initState
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUserData().then((value) {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;
    // print(user.userName);
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
        title: Text(
          'Profile',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 17),
        ),
        elevation: 0.0,
      ),
      drawer: SideDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 100.0,
                            bottom: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user.userName}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${user.userEmail}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Icon(Icons.edit),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: tileItems.length,
                              itemBuilder: (context, index) {
                                return listTile(
                                    tileItems[index][0], tileItems[index][1]);
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.userImage!),
                radius: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listTile(IconData icon, String title) {
    if (title == "Log Out") {
      return InkWell(
        onTap: () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pop();
          print("User Signed Out");
        },
        child: Column(
          children: [
            const Divider(
              height: 1,
            ),
            ListTile(
              leading: Icon(icon),
              title: Text(title),
              trailing: const Icon(Icons.navigate_next_sharp),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.navigate_next_sharp),
        ),
      ],
    );
  }
}
