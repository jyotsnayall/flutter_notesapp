import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:notesapp/models/notes_model.dart';
import 'package:notesapp/stores/notes_store.dart';

class EditNote extends StatefulWidget {
  // final NotesModel note;
  final String noteId;
  EditNote({
    super.key,
    // required this.note,
    required this.noteId,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // @override
  // void dispose() {
  //   titleController.dispose();
  //   descriptionController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final NotesModel note = store.notes.firstWhere((element) => element.id == widget.noteId);
    print('ID in edit note screen: ${note.id}');

    titleController.text = note.title;
    descriptionController.text = note.description;

    return Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        backgroundColor: Color(0xff252525),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 10, top: 10),
            child: Observer(
              builder: (context) {
                return ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  onPressed: () {
                    store.editNote(
                        note, titleController.text, descriptionController.text);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(5),
                    backgroundColor: Color(0xff3B3B3B),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextField(
                  maxLines: null,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    decoration: TextDecoration.none,
                  ),
                  controller: titleController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(
                      color: Color(0xff929292),
                      fontSize: 30,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    expands: true,
                    maxLines: null,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                    ),
                    controller: descriptionController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type something....",
                      hintStyle: TextStyle(
                        color: Color(0xff929292),
                        fontSize: 20,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: TextField(
              //     maxLines: null,
              //     textCapitalization: TextCapitalization.none,
              //     keyboardType: TextInputType.visiblePassword,
              //     style: TextStyle(
              //       // fontSize: Theme.of(context).textTheme.headline4.fontSize,
              //       color: Colors.white,
              //       decoration: TextDecoration.none,
              //     ),
              //     controller: titleController,
              //     cursorColor: Colors.white,
              //     decoration: InputDecoration(
              //       border: InputBorder.none,
              //       hintText: "Title",
              //       hintStyle: TextStyle(
              //         color: Color(0xff929292),
              //         // fontSize: Theme.of(context).textTheme.headline4.fontSize,
              //         letterSpacing: 1.5,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
