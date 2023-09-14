import 'package:flutter/material.dart';
import 'package:my_notes/note/model/note_entity.dart';
import 'package:my_notes/note/provider/note_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final noteProvider = context.watch<NoteProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My notes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Note>>(
          future: noteProvider.listAll(),
          builder: (context, snapshot) {
            final List<Note> _list = snapshot.data ?? [];
            return ListView(
              children: _list
                  .map(
                    (e) => GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, "/edit", arguments: e),
                      child: ListTile(
                        title: Text(e.title),
                        subtitle: Text(e.text),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => noteProvider.remove(e),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
