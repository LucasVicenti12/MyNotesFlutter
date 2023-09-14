import 'package:flutter/material.dart';
import 'package:my_notes/note/model/note_entity.dart';
import 'package:my_notes/note/provider/note_provider.dart';
import 'package:my_notes/note/view/note_form.dart';
import 'package:my_notes/shared/page/home_page.dart';
import 'package:my_notes/shared/theme/theme_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      builder: (context, child) => const RoutesWidget(),
    ),
  );
}

class RoutesWidget extends StatelessWidget {
  const RoutesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeController.instance,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            brightness: ThemeController.instance.isDarkTheme
                ? Brightness.dark
                : Brightness.light,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/create': (context) => const NoteForm(),
            '/edit': (context){
              final entity = ModalRoute.of(context)?.settings.arguments as Note;
              return NoteForm(entity: entity);
            },
          },
        );
      },
    );
  }
}
