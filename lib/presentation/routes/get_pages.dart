import 'package:get/get.dart';
import 'package:todolist/presentation/notes/note_form/note_form_page.dart';
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
      GetPage(
        name: Routes.noteFormPage,
        page: () => const NoteFormPage(editedNote: null),
        fullscreenDialog: true,
      ),
    ];
  }
}

class Routes {
  static const String splashPage = '/';
  static const String signInPage = '/sign-in';
  static const String noteOverviewPage = '/note';
  static const String noteFormPage = '/note-form';
}
