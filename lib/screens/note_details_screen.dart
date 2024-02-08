import 'package:flutter/material.dart';
import 'package:notesapp/models/notes_model.dart';
import 'package:notesapp/screens/edit_note_screen.dart';

class NoteDetails extends StatelessWidget {
  final NotesModel note;

  NoteDetails({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        backgroundColor: Color(0xff252525),
        iconTheme: IconThemeData(color: Colors.white),
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
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            note.title,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: IconButton(
                              splashColor: Colors.transparent,
                              enableFeedback: true,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => EditNote(note: note),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                              ),
                              color: Colors.white,
                            ),
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
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        note.description,
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
