import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/boxes/boxes.dart';
import 'package:notesapp/models/notes_model.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getNotes().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();

          // double aspectRatio = MediaQuery.of(context).size.width ; // 150 is the desired width of the item

          // return GridView.builder(
          return MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: data.length,
            itemBuilder: (context, index) {
              NotesModel note = data[index];

              Color color = colors[index % colors.length];
              return InkWell(
                onTap: () {
                  print('tapped');
                },
                child: Card(
                  color: color,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Text(
                                data[index].title.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(207, 0, 0, 0),
                                ),
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              child: InkWell(
                                child: Icon(Icons.delete, color: Colors.red),
                                onTap: () {
                                  delete(data[index]);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  _editDialog(
                                    data[index],
                                    data[index].title.toString(),
                                    data[index].description.toString(),
                                  );
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: const Color.fromARGB(207, 0, 0, 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(data[index].description.toString()),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      // body: Column(
      //   children: [
      //     FutureBuilder(
      //       future: Hive.openBox('testnote'),
      //       builder: (context, snapshot) {
      //         return Column(
      //           children: [
      //             ListTile(
      //               title: Text(
      //                   'Title: ${snapshot.data!.get('title').toString()}'),
      //               subtitle:
      //                   Text(snapshot.data!.get('description').toString()),
      //               trailing: IconButton(
      //                 icon: const Icon(Icons.edit),
      //                 onPressed: () {
      //                   snapshot.data!.put('title', 'Updated title');
      //                 },
      //               ),
      //             ),
      //           ],
      //         );
      //       },
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () async {
        //   var box = await Hive.openBox('testnote');

        //   box.put('title', 'My first note');
        //   box.put('description', 'lorem ipsum first note');

        //   print(box.get('title'));
        //   print(box.get('description'));
        // },
        onPressed: () {
          _showMyDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  Future<void> _editDialog(
      NotesModel notesModel, String title, String description) async {
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
              onPressed: () async {
                notesModel.title = titleController.text;
                notesModel.description = descriptionController.text;

                await notesModel.save();

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

  Future<void> _showMyDialog() async {
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
              onPressed: () {
                titleController.clear();
                descriptionController.clear();

                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final data = NotesModel(
                  title: titleController.text,
                  description: descriptionController.text,
                );

                final box = Boxes.getNotes();
                box.add(data);

                data.save();
                titleController.clear();
                descriptionController.clear();

                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
