import 'package:my_notes/note/controller/note_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'app.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(NoteDAO.noteTable);
    },
    version: 1,
  );
}
