import 'package:flutter/material.dart';
import 'package:my_notes/note/dto/note_entity_dto.dart';
import 'package:my_notes/note/model/note_entity.dart';
import 'package:my_notes/note/provider/note_provider.dart';
import 'package:my_notes/shared/components/text_input.dart';
import 'package:provider/provider.dart';

class NoteForm extends StatefulWidget {
  final Note? entity;

  const NoteForm({Key? key, this.entity}) : super(key: key);

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  late NoteDTO noteDTO;

  @override
  void initState() {
    super.initState();
    if(widget.entity != null){
      noteDTO = NoteDTO(
        uuid: widget.entity!.uuid,
        title: widget.entity!.title,
        text: widget.entity!.text
      );
    }else{
      noteDTO = NoteDTO();
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = context.watch<NoteProvider>();

    void save() {
      noteProvider.save(noteDTO);
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextInput(
              key: Key('title:${noteDTO.hashCode}'),
              hint: 'Title',
              initialValue: noteDTO.title,
              validator: noteDTO.titleValidate,
              onChanged: (value) => noteDTO.title = value,
            ),
            const SizedBox(height: 5),
            TextInput(
              key: Key('text:${noteDTO.hashCode}'),
              hint: 'Text',
              initialValue: noteDTO.text,
              validator: noteDTO.textValidate,
              rows: 5,
              onChanged: (value) => noteDTO.text = value,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(onPressed: save, child: const Text('Save'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
