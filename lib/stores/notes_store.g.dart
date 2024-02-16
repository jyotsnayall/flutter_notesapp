// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotesStore on _NotesStore, Store {
  late final _$notesAtom = Atom(name: '_NotesStore.notes', context: context);

  @override
  List<NotesModel> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(List<NotesModel> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$pinnedNotesAtom =
      Atom(name: '_NotesStore.pinnedNotes', context: context);

  @override
  List<NotesModel> get pinnedNotes {
    _$pinnedNotesAtom.reportRead();
    return super.pinnedNotes;
  }

  @override
  set pinnedNotes(List<NotesModel> value) {
    _$pinnedNotesAtom.reportWrite(value, super.pinnedNotes, () {
      super.pinnedNotes = value;
    });
  }

  late final _$searchResultNotesAtom =
      Atom(name: '_NotesStore.searchResultNotes', context: context);

  @override
  List<NotesModel> get searchResultNotes {
    _$searchResultNotesAtom.reportRead();
    return super.searchResultNotes;
  }

  @override
  set searchResultNotes(List<NotesModel> value) {
    _$searchResultNotesAtom.reportWrite(value, super.searchResultNotes, () {
      super.searchResultNotes = value;
    });
  }

  late final _$initFireDBAtom =
      Atom(name: '_NotesStore.initFireDB', context: context);

  @override
  bool get initFireDB {
    _$initFireDBAtom.reportRead();
    return super.initFireDB;
  }

  @override
  set initFireDB(bool value) {
    _$initFireDBAtom.reportWrite(value, super.initFireDB, () {
      super.initFireDB = value;
    });
  }

  late final _$boxAtom = Atom(name: '_NotesStore.box', context: context);

  @override
  Box<NotesModel> get box {
    _$boxAtom.reportRead();
    return super.box;
  }

  bool _boxIsInitialized = false;

  @override
  set box(Box<NotesModel> value) {
    _$boxAtom.reportWrite(value, _boxIsInitialized ? super.box : null, () {
      super.box = value;
      _boxIsInitialized = true;
    });
  }

  late final _$isLoggedinAtom =
      Atom(name: '_NotesStore.isLoggedin', context: context);

  @override
  bool get isLoggedin {
    _$isLoggedinAtom.reportRead();
    return super.isLoggedin;
  }

  @override
  set isLoggedin(bool value) {
    _$isLoggedinAtom.reportWrite(value, super.isLoggedin, () {
      super.isLoggedin = value;
    });
  }

  late final _$current_userAtom =
      Atom(name: '_NotesStore.current_user', context: context);

  @override
  User? get current_user {
    _$current_userAtom.reportRead();
    return super.current_user;
  }

  bool _current_userIsInitialized = false;

  @override
  set current_user(User? value) {
    _$current_userAtom.reportWrite(
        value, _current_userIsInitialized ? super.current_user : null, () {
      super.current_user = value;
      _current_userIsInitialized = true;
    });
  }

  late final _$collectionRefAtom =
      Atom(name: '_NotesStore.collectionRef', context: context);

  @override
  CollectionReference<Object?> get collectionRef {
    _$collectionRefAtom.reportRead();
    return super.collectionRef;
  }

  bool _collectionRefIsInitialized = false;

  @override
  set collectionRef(CollectionReference<Object?> value) {
    _$collectionRefAtom.reportWrite(
        value, _collectionRefIsInitialized ? super.collectionRef : null, () {
      super.collectionRef = value;
      _collectionRefIsInitialized = true;
    });
  }

  late final _$initFirebaseAsyncAction =
      AsyncAction('_NotesStore.initFirebase', context: context);

  @override
  Future<void> initFirebase() {
    return _$initFirebaseAsyncAction.run(() => super.initFirebase());
  }

  late final _$initAsyncAction =
      AsyncAction('_NotesStore.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$getNotesFromFirebaseAsyncAction =
      AsyncAction('_NotesStore.getNotesFromFirebase', context: context);

  @override
  Future<void> getNotesFromFirebase() {
    return _$getNotesFromFirebaseAsyncAction
        .run(() => super.getNotesFromFirebase());
  }

  late final _$editNoteAsyncAction =
      AsyncAction('_NotesStore.editNote', context: context);

  @override
  Future<void> editNote(NotesModel note, String title, String description) {
    return _$editNoteAsyncAction
        .run(() => super.editNote(note, title, description));
  }

  late final _$removeNoteAsyncAction =
      AsyncAction('_NotesStore.removeNote', context: context);

  @override
  Future<void> removeNote(NotesModel note) {
    return _$removeNoteAsyncAction.run(() => super.removeNote(note));
  }

  late final _$togglePinAsyncAction =
      AsyncAction('_NotesStore.togglePin', context: context);

  @override
  Future<void> togglePin(NotesModel note) {
    return _$togglePinAsyncAction.run(() => super.togglePin(note));
  }

  late final _$fetchNoteFromFirebaseAsyncAction =
      AsyncAction('_NotesStore.fetchNoteFromFirebase', context: context);

  @override
  Future<NotesModel> fetchNoteFromFirebase(String noteId) {
    return _$fetchNoteFromFirebaseAsyncAction
        .run(() => super.fetchNoteFromFirebase(noteId));
  }

  late final _$_NotesStoreActionController =
      ActionController(name: '_NotesStore', context: context);

  @override
  void getCurrentUser() {
    final _$actionInfo = _$_NotesStoreActionController.startAction(
        name: '_NotesStore.getCurrentUser');
    try {
      return super.getCurrentUser();
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCollectionReference() {
    final _$actionInfo = _$_NotesStoreActionController.startAction(
        name: '_NotesStore.getCollectionReference');
    try {
      return super.getCollectionReference();
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNoteToFirebase(String id, String title, String description) {
    final _$actionInfo = _$_NotesStoreActionController.startAction(
        name: '_NotesStore.addNoteToFirebase');
    try {
      return super.addNoteToFirebase(id, title, description);
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getNotes() {
    final _$actionInfo =
        _$_NotesStoreActionController.startAction(name: '_NotesStore.getNotes');
    try {
      return super.getNotes();
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNote(String id, String title, String description) {
    final _$actionInfo =
        _$_NotesStoreActionController.startAction(name: '_NotesStore.addNote');
    try {
      return super.addNote(id, title, description);
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearNotes() {
    final _$actionInfo = _$_NotesStoreActionController.startAction(
        name: '_NotesStore.clearNotes');
    try {
      return super.clearNotes();
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSearch() {
    final _$actionInfo = _$_NotesStoreActionController.startAction(
        name: '_NotesStore.clearSearch');
    try {
      return super.clearSearch();
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void search(String query) {
    final _$actionInfo =
        _$_NotesStoreActionController.startAction(name: '_NotesStore.search');
    try {
      return super.search(query);
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notes: ${notes},
pinnedNotes: ${pinnedNotes},
searchResultNotes: ${searchResultNotes},
initFireDB: ${initFireDB},
box: ${box},
isLoggedin: ${isLoggedin},
current_user: ${current_user},
collectionRef: ${collectionRef}
    ''';
  }
}
