import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String profileImageURL = "https://picsum.photos/200";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    height: 160,
                    width: 160,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: profileImageURL,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: Theme.of(context).primaryColor,
                      ),
                      errorWidget: (context, url, downloadProgress) =>
                          const Icon(Icons.error_outline),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text("username", style: TextStyle(fontSize: 18)),
              Text("email", style: TextStyle(fontSize: 18)),
              Text("phone", style: TextStyle(fontSize: 18)),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.collections_bookmark_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text("Saved Properties"),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.payments_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text("Payment Information"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text("Help and Support"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text("Logout"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Divider(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
