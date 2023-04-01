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
          const SizedBox(height: 32),
          CircleAvatar(
            radius: 64,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: profileImageURL,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Theme.of(context).primaryColor,
              ),
              errorWidget: (context, url, downloadProgress) =>
                  const Icon(Icons.error_outline),
            ),
          )
        ],
      ),
    );
  }
}
