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
  List<NotesModel> pinnedNotes = ObservableList<NotesModel>();

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

  @observable
  int changeCounter = 0;

  // @observable
  // late QuerySnapshot querySnapshot;

  var uuid = Uuid();

  @action
  Future<void> initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    print('Firebase initialized');
  }

  @action
  Future<void> init() async {
    getCollectionReference();
    notes.clear();
    pinnedNotes.clear();
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
    pinnedNotes.clear();
    await collectionRef
        .where('isPinned', isEqualTo: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
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

    await collectionRef
        .where('isPinned', isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      print("=====================Pinned Notes=====================");
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

        pinnedNotes.add(note);
      });
    });
  }

  @action
  void addNoteToFirebase(
      final String id, final String title, final String description) {
    final note = NotesModel(
        id: id, title: title, description: description, isPinned: false);
    print('ID in add note: $id');

    getCollectionReference();
    collectionRef.doc(note.id.toString()).set({
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

  // @action
  // Future<void> getSnapshot() async {
  //   querySnapshot = await collectionRef.get();
  // }

  // @action
  // Future<void> getNotes() async {
  //   getSnapshot();

  //   // notes = querySnapshot.docs
  //   //     .map((e) => NotesModel(
  //   //         id: e.id,
  //   //         title: e['title'],
  //   //         description: e['description'],
  //   //         isPinned: e['isPinned']))
  //   //     .toList()
  //   //     .cast<NotesModel>();

  //   notes = querySnapshot.docs
  //       .map((docs) => docs.data())
  //       .toList()
  //       .cast<NotesModel>();

  //     getBox();
  //   pinnedNotes = box.values
  //       .where((element) => element.isPinned == true)
  //       .toList()
  //       .cast<NotesModel>();
  // }

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

    // Search in notes
    for (var note in notes) {
      if (note.title.contains(query) || note.description.contains(query)) {
        searchResultNotes.add(note);
      }
    }

    // Search in pinnedNotes
    for (var note in pinnedNotes) {
      if (note.title.contains(query) || note.description.contains(query)) {
        searchResultNotes.add(note);
      }
    }

    // final ResultIds =
    //     await NotesDatabse.instance.getNoteString(query); //= [1,2,3,4,5]
    // List<Note?> SearchResultNotesLocal = []; //[nOTE1, nOTE2]
    // ResultIds.forEach(
    //   (element) async {
    //     final SearchNote = await NotesDatabse.instance.readOneNote(element);
    //     SearchResultNotesLocal.add(SearchNote);

    //         searchResultNotes.add(SearchNote);
    //     );
    //   },
    // );
  }
}

final store = NotesStore();
