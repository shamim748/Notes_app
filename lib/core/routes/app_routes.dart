import 'package:go_router/go_router.dart';
import 'package:note_app/features/Add_or_update/view/add_or_update_view.dart';
import 'package:note_app/features/home/model/note_model.dart';
import 'package:note_app/features/home/view/home_view.dart';
import 'package:note_app/features/sign_up/view/sign_up_view.dart';
import 'package:note_app/features/signin/view/sign_in_view.dart';
import 'package:note_app/features/splash/view/splash.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/signin', builder: (context, state) => const SignInView()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpView()),
    GoRoute(path: '/home', builder: (context, state) => const HomeView()),

    GoRoute(
      path: '/update',
      builder: (context, state) {
        NoteModel noteModel = state.extra as NoteModel;
        return AddOrUpdateView(noteModel: noteModel);
      },
    ),
  ],
);
