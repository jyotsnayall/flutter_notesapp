import 'package:flutter/material.dart';
import 'package:notesapp/screens/edit_note_screen.dart';
import 'package:notesapp/screens/home_screen.dart';
import 'package:notesapp/screens/login_screen.dart';
import 'package:notesapp/services/auth.dart';
import 'package:notesapp/stores/notes_store.dart';
import 'package:uuid/uuid.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 68, 68, 68),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[400],
              ),
              child: Text(
                'Stay Organized',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.event_note,
                color: Colors.white,
              ),
              title: Text(
                'Notes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.add,
                color: Colors.white,
              ),
              title: Text(
                'Add Note',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                final id = Uuid().v1();
                store.addNote(id, '', '');
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => EditNote(noteId: id)),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              title: Text(
                'Clear all notes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                store.clearNotes();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // store.clearNotes();
                signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
