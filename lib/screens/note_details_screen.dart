import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:notesapp/models/notes_model.dart';
import 'package:notesapp/screens/edit_note_screen.dart';
import 'package:notesapp/stores/notes_store.dart';

class NoteDetails extends StatelessWidget {
  // NotesModel note;
  int index;

  NoteDetails({
    super.key,
    // required this.note,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        backgroundColor: Color(0xff252525),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: [
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(left: 10, right: 5, top: 10),
            alignment: Alignment.center,
            child: IconButton(
              splashColor: Colors.transparent,
              enableFeedback: true,
              onPressed: () async {
                print("Button Pressed");
                print('Store note reference (Before): ${store.notes[index].hashCode}');
                
                await store.togglePin(store.notes[index]).then((value) {
                  print('Store Note Pinned: ${store.notes[index].isPinned}');
                  print('Store note reference (After): ${store.notes[index].hashCode} inside then');
                });
                print('Pinned: ${store.notes[index].isPinned}');
                // Navigator.pop(context);
              },
              icon: Observer(
                builder: (context) {
                  print('Rebuilding Icon widget');
                  // print('List reference: ${note.hashCode} inside Observer');
                  print('note pin: ${store.notes[index].isPinned}');
                  return Icon(
                    store.notes[index].isPinned
                        ? Icons.push_pin
                        : Icons.push_pin_outlined,
                  );
                },
              ),
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              color: Color(0xff3B3B3B),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            alignment: Alignment.center,
            child: IconButton(
              splashColor: Colors.transparent,
              enableFeedback: true,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => EditNote(noteId: store.notes[index].id),
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
              ),
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              color: Color(0xff3B3B3B),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        store.notes[index].title,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        store.notes[index].description,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
