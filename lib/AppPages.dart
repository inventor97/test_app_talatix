import 'package:get/get.dart';
import 'package:test_app_talatix/AppRoutes.dart';
import 'pages/_pages.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.BASE,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.USER_DETAILED,
      page: () => const UserDetailedPage(),
      binding: UserDetailedBinding(),
    ),
    GetPage(
      name: AppRoutes.POSTS,
      page: () => const PostsPage(),
      binding: PostsBinding(),
    ),
    GetPage(
      name: AppRoutes.ALBUMS,
      page: () => const AlbumsPage(),
      binding: AlbumsBinding(),
    ),
    GetPage(
      name: AppRoutes.COMMENTS,
      page: () => const CommentsPage(),
      binding: CommentsBinding(),
    ),
  ];
}
