import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notesapp/models/notes_model.dart';
import 'package:notesapp/screens/note_details_screen.dart';

import '../stores/notes_store.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_outlined),
                      color: Colors.white,
                    ),
                    Flexible(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Type here...",
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 16),
                        ),
                        onSubmitted: (value) {
                          store.search(value.toLowerCase());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "SEARCH RESULTS",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Observer(builder: (context) {
                if (store.searchResultNotes.isEmpty)
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No notes found',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                else
                  return notesGridView(store.searchResultNotes);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget notesGridView(List<NotesModel> notes) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          scrollDirection: Axis.vertical,
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            final note = notes[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NoteDetails(index: index),
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              note.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(note.isPinned?Icons.push_pin:Icons.push_pin_outlined)
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        note.description,
                        style: TextStyle(fontSize: 14),
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
