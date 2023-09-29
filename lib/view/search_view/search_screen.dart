import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/core/constant/color.dart';
import 'package:instagramclone/view/profile_view/profile_screen.dart';
import 'package:instagramclone/controller/home_controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchControllerImp _searchControllerImp =
      Get.put(SearchControllerImp());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllerImp>(builder: (_) {
      return Scaffold(
          backgroundColor: mobileBackgroundColor,
          appBar: AppBar(
            backgroundColor: mobileBackgroundColor,
            title: TextFormField(
              onChanged: (value) {
                _searchControllerImp.searchUsers(value);
              },
              // controller: _searchControllerImp.myController,
              decoration:
                  const InputDecoration(labelText: 'Search for a user...'),
            ),
            leading: _searchControllerImp.showBackButton
                ? IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      _searchControllerImp.isBoll(false);
                    },
                  )
                : null,
          ),
          body: GetBuilder<SearchControllerImp>(
            builder: (_) {
              if (_searchControllerImp.users.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: _searchControllerImp.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        Get.to(
                          () => ProfileScreen(
                            uid: _searchControllerImp.users[index]["uid"],
                          ),
                        );
                      },
                      title: Text(_searchControllerImp.users[index]['name']),
                      leading: CircleAvatar(
                        radius: 33,
                        backgroundImage: NetworkImage(
                            _searchControllerImp.users[index]['profileImg']),
                      ),
                    );
                  },
                );
              }
            },
          ));
    });
  }
}
