import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _Profile();
}

class _Profile extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final _items = [
    "assets/analog.jpg",
    "assets/bird.jpg",
    "assets/man with a cap.jpg",
    "assets/man with shadow.jpg",
    "assets/plant.jpg",
    "assets/sofia building.jpg",
    "assets/boy.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 79),
                        child: Container(
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.person,
                              size: 80.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        currentUser?.displayName ?? 'User',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          fixedSize: Size(133, 44),
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black,
                    indicator: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                    tabs: [
                      Tab(text: 'Uploaded'),
                      Tab(text: 'Saved'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              //uploaded page
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: _items.length > 20 ? _items.length : 20,
                itemBuilder: (BuildContext context, int index) {
                  final imageUrl = _items[index % _items.length];
                  return Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  );
                },
              ),

              // saved page
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    _items[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
