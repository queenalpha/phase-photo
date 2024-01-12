import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phase_photo/components/button.dart';
import 'package:phase_photo/pages/edit_profile.dart';
import 'package:phase_photo/services/data_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _Profile();
}

class _Profile extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final dataService = DataServices();

  late Stream<List<DocumentSnapshot>> _imagesStream;

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
  void initState() {
    super.initState();
    _imagesStream =
        dataService.getImagesByUser(currentUser!.displayName!).asStream();
  }

  Future<void> refreshData() async {
    setState(() {
      _imagesStream =
          dataService.getImagesByUser(currentUser!.displayName!).asStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    // refreshData();
    return Scaffold(
      body: DefaultTabController(
        length: 1,
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
                            //  backgroundImage:
                            //                   NetworkImage(fileUri + profpic),
                            //               child: profpic == '-'
                            //                   ? Icon(
                            //                       color: Colors.grey[500],
                            //                       Icons.person,
                            //                       size: 70.0,
                            //                     )
                            //                   : SizedBox.shrink(),
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
                      buttons(
                        onPressed: () {
                          Navigator.pushNamed(context, 'editProfile');
                        },
                        colour: Colors.grey,
                        title: 'Edit Profile',
                        textColor: Colors.white,
                        width: 133,
                        height: 44,
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
                      // Tab(text: 'Saved'),
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
              StreamBuilder(
                stream: _imagesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        'Gallery kosong',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'Gallery kosong',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  } else {
                    List<DocumentSnapshot> imagesSnapshot = snapshot.data!;
                    print(imagesSnapshot.length);
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: imagesSnapshot.length,
                      itemBuilder: (context, index) {
                        // final imageUrl = _items[index % _items.length];
                        return Image.network(
                          imagesSnapshot.elementAt(index).get('image_url'),
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }
                },
              ),

              // saved page
              // GridView.builder(
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 3,
              //     mainAxisSpacing: 4.0,
              //     crossAxisSpacing: 4.0,
              //     childAspectRatio: 1.0,
              //   ),
              //   itemCount: 5,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Image.asset(
              //       _items[index],
              //       fit: BoxFit.cover,
              //     );
              //   },
              // ),
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
