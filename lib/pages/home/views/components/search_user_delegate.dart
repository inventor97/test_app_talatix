import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/models/user_info_model.dart';
import 'package:test_app_talatix/pages/home/views/components/search_result.dart';
import 'package:test_app_talatix/services/storage_service.dart';
import 'package:test_app_talatix/widgets/error_component.dart';

class SearchUsersDelegate extends SearchDelegate {
  List<UserInfoModel> users;

  SearchUsersDelegate(this.users) : super(searchFieldLabel: "search".tr, searchFieldStyle: const TextStyle(fontSize: 15));

  final storage = Get.find<StorageService>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Config.primaryColor),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Config.primaryColor),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserInfoModel> results = users.where((e) {
      return e.name!.toLowerCase().contains(query.toLowerCase()) || e.username!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return (query != "")
        ? (results.isNotEmpty)
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: SearchResult(users: results),
              )
            : Center(
                child: ErrorComponent(
                  icon: Icons.question_answer_outlined,
                  label: "nothing_found".tr,
                ),
              )
        : const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<UserInfoModel> results = users.where((e) {
      return e.name!.toLowerCase().contains(query.toLowerCase()) || e.username!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return (query != "")
        ? (results.isNotEmpty)
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: SearchResult(users: results),
              )
            : Center(
                child: ErrorComponent(
                  icon: Icons.question_answer_outlined,
                  label: "nothing_found".tr,
                ),
              )
        : const SizedBox();
  }
}
