import 'package:get/get.dart';
import 'package:todolist/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:todolist/presentation/sign_in/sign_in_page.dart';
import 'package:todolist/presentation/splash/splash_page.dart';

extension GetPagesX on GetInterface {
  

  List<GetPage<dynamic>> getPages() {
    return [
      GetPage(name: '/', page: () => SplashPage()),
      GetPage(name: '/sign-in', page: () => SignInPage()),
      GetPage(name: '/note', page: () => const NoteOverviewPage()),
    ];
  }
}
