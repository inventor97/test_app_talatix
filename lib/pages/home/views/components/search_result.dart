import 'package:flutter/material.dart';
import 'package:test_app_talatix/models/user_info_model.dart';
import 'package:test_app_talatix/pages/home/views/components/user_info_tile.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<UserInfoModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: users.length,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      itemBuilder: (context, index) {
        final user = users[index];
        return UserInfoTile(user: user);
      },
    );
  }
}
