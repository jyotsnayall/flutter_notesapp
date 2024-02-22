import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
import '../models/notes_model.dart';

part 'notes_store.g.dart';

class NotesStore = _NotesStore with _$NotesStore;

abstract class _NotesStore with Store {
  @observable
  List<NotesModel> notes = ObservableList<NotesModel>();

  @observable
  List<NotesModel> searchResultNotes = ObservableList<NotesModel>();

  @observable
  bool initFireDB = false;

  @observable
  bool isLoggedin = false;

  @observable
  late User? current_user;

  @observable
  late CollectionReference collectionRef;

  var uuid = Uuid();

  @action
  Future<void> init() async {
    getNotesFromFirebase();

    print("fetched notes from firebase");
    for (var note in notes) {
      print(note.title);
    }

    initFireDB = true;
  }

  @action
  void getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      current_user = user;
      isLoggedin = true;
    } else {
      isLoggedin = false;
    }
  }

  @action
  void getCollectionReference() {
    getCurrentUser();
    collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(current_user!.email)
        .collection('notes');
  }

  @action
  Future<void> getNotesFromFirebase() async {
    getCollectionReference();
    notes.clear();
    await collectionRef.get().then((QuerySnapshot querySnapshot) {
      print(
          '=====================Fetched notes successfully=====================');
      querySnapshot.docs.forEach((doc) {
        print(doc['title']);
        print(doc['description']);
        print(doc['id']);
        print(doc['isPinned']);

        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        final note = NotesModel(
            id: data['id'],
            title: data['title'],
            description: data['description'],
            isPinned: data['isPinned']);

        notes.add(note);
      });
    });
  }

  @action
  Future<void> addNoteToFirebase(
      final String id, final String title, final String description) async {
    final note = NotesModel(
        id: id, title: title, description: description, isPinned: false);
    print('ID in add note: $id');

    getCollectionReference();
    await collectionRef.doc(note.id.toString()).set({
      'id': id,
      'title': title,
      'description': description,
      'isPinned': note.isPinned
    }).then((value) {
      print('Note added to firebase');
    });
    getNotesFromFirebase();
  }

  @action
  Future<void> editNote(final NotesModel note, final String title,
      final String description) async {
    getCollectionReference();
    await collectionRef.doc(note.id).update({
      'title': title,
      'description': description,
    }).then((value) {
      print('Note updated in firebase');
    });
    getNotesFromFirebase();
  }

  @action
  Future<void> removeNote(NotesModel note) async {
    getCollectionReference();
    await collectionRef.doc(note.id).delete().then((value) {
      print('Note deleted from firebase');
    });
    getNotesFromFirebase();
  }

  @action
  Future<void> clearNotes() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(current_user!.email)
          .collection('notes')
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      print('All documents deleted successfully');
    } catch (e) {
      print('Error deleting documents: $e');
    }
    getNotesFromFirebase();
  }

  @action
  Future<void> togglePin(NotesModel note) async {
    getCollectionReference();
    await collectionRef.doc(note.id).update({
      'isPinned': !note.isPinned,
    }).then((value) {
      print('Note Pinned value changed in firebase');
    });
    await getNotesFromFirebase();
  }

  @action
  Future<NotesModel> fetchNote(String noteId) async {
    getCollectionReference();
    final DocumentSnapshot document = await collectionRef.doc(noteId).get();

    if (document.exists) {
      print('Document data: ${document.data()}');

      final note = NotesModel(
        id: document['id'],
        title: document['title'],
        description: document['description'],
        isPinned: document['isPinned'],
      );
      return note;
    } else {
      print('Document does not exist on the database');
      throw Exception('Document does not exist on the database');
    }
  }

  @action
  void clearSearch() {
    searchResultNotes.clear();
  }

  @action
  void search(String query) {
    clearSearch();
    for (var note in notes) {
      if (note.title.contains(query) || note.description.contains(query)) {
        searchResultNotes.add(note);
      }
    }
  }
}

final store = NotesStore();
