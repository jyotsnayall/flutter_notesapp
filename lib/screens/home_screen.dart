import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:notesapp/models/notes_model.dart';
import 'package:notesapp/screens/edit_note_screen.dart';
import 'package:notesapp/screens/note_details_screen.dart';
import 'package:notesapp/screens/search_screen.dart';
import 'package:notesapp/stores/notes_store.dart';
import 'package:notesapp/widgets/main_drawer.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final searchController = TextEditingController();

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
          'Your Notes',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xff252525),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      key: _drawerKey,
      drawer: MainDrawer(),
      body: Observer(
        builder: (context) {
          if (!store.initHiveDB) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                // SingleChildScrollView(
                Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 68, 68, 68),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        store.clearSearch();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SearchView(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'Search your notes...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // ),
                if (store.pinnedNotes.isNotEmpty)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "PINNED",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                if (store.pinnedNotes.isNotEmpty)
                  notesGridView(store.pinnedNotes),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "OTHERS",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                notesGridView(store.notes),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _showMyDialog();
          final id = Uuid().v1();
          store.addNote(id, '', '');
          print('ID on home screen: $id');
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => EditNote(noteId: id)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

//   Widget notesStaggeredView(List<NotesModel> notes) {
//   return Flexible(
//     child: Padding(
//       padding: EdgeInsets.only(top: 8),
//       child: StaggeredGrid.countBuilder(
//         crossAxisCount: 2,
//         itemCount: notes.length,
//         itemBuilder: (BuildContext context, int index) {
//           final note = notes[index];
//           final color = colors[index % colors.length];
//           return InkWell(
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => NoteDetails(note: note),
//                 ),
//               );
//             },
//             child: Card(
//               color: color,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             note.title,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         InkWell(
//                           child: Icon(Icons.delete, color: Colors.red),
//                           onTap: () {
//                             store.removeNote(note);
//                           },
//                         ),
//                         SizedBox(width: 10),
//                         InkWell(
//                           onTap: () {
//                             _editDialog(
//                               note,
//                               note.title.toString(),
//                               note.description.toString(),
//                             );
//                           },
//                           child: Icon(
//                             Icons.edit,
//                             color: const Color.fromARGB(207, 0, 0, 0),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       note.description,
//                       style: TextStyle(fontSize: 14),
//                       maxLines: 8,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//         staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
//         mainAxisSpacing: 4.0,
//         crossAxisSpacing: 4.0,
//       ),
//     ),
//   );
// }

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
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         EditNote(note: note),
                              //   ),
                              // );
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
      ),
    );
  }

  Widget notesListView(List<NotesModel> notes) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: ListView.builder(
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
                print('outside fn ID: ${note.id}');
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
                final id = Uuid().v1();
                store.addNote(
                    id, titleController.text, descriptionController.text);
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
