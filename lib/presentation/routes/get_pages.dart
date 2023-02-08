import 'package:get/get.dart';
import 'package:todolist/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:todolist/presentation/sign_in/sign_in_page.dart';
import 'package:todolist/presentation/splash/splash_page.dart';

extension GetPagesX on GetInterface {
  List<GetPage<dynamic>> getPages() {
    return [
      GetPage(
        name: Routes.splashPage,
        page: () => SplashPage(),
        transition: Transition.fade,
      ),
      GetPage(name: Routes.signInPage, page: () => SignInPage()),
      GetPage(
        name: Routes.noteOverviewPage,
        page: () => const NoteOverviewPage(),
        transition: Transition.zoom,
      ),
    ];
  }
}

class Routes {
  static const String splashPage = '/';
  static const String signInPage = '/sign-in';
  static const String noteOverviewPage = '/note';
}
