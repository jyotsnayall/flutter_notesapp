import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:notesapp/models/notes_model.dart';
import 'package:notesapp/screens/note_details_screen.dart';
import 'package:notesapp/stores/notes_store.dart';

final NotesStore store = NotesStore();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final List<Color> colors = [
    Color(0xFFFF8A80), // Red
    Color(0xFFFFD180), // Orange
    Color(0xFFFFF176), // Yellow
    Color(0xFFCCFF90), // Green
    Color(0xFF80D8FF), // Blue
    Color(0xFFB388FF), // Purple
    Color(0xFFFF80AB), // Pink
    Color(0xFFCFD8DC), // Gray
  ];

  @override
  void initState() {
    super.initState();
    store.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        title: const Text(
          'Notes App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: Color(0xff252525),
      ),
      body: Observer(
        builder: (context) {
          if (!store.initHiveDB) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: store.notes.length,
              itemBuilder: (BuildContext context, int index) {
                final note = store.notes[index];
                final color = colors[index % colors.length];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NoteDetails(note: note),
                      ),
                    );
                  },
                  child: Card(
                    color: color,
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
                              InkWell(
                                child: Icon(Icons.delete, color: Colors.red),
                                onTap: () {
                                  store.removeNote(note);
                                },
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  _editDialog(
                                    note,
                                    note.title.toString(),
                                    note.description.toString(),
                                  );
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: const Color.fromARGB(207, 0, 0, 0),
                                ),
                              ),
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _editDialog(
      NotesModel note, String title, String description) async {
    titleController.text = title;
    descriptionController.text = description;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                store.editNote(
                    note, titleController.text, descriptionController.text);

                titleController.clear();
                descriptionController.clear();

                Navigator.pop(context);
              },
              child: Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                titleController.clear();
                descriptionController.clear();

                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                // final data = NotesModel(
                //   title: titleController.text,
                //   description: descriptionController.text,
                // );

                // final box = Boxes.getNotes();
                // box.add(data);

                // data.save();
                store.addNote(titleController.text, descriptionController.text);
                titleController.clear();
                descriptionController.clear();

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
