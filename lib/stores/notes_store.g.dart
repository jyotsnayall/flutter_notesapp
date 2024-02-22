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

  late final _$addNoteToFirebaseAsyncAction =
      AsyncAction('_NotesStore.addNoteToFirebase', context: context);

  @override
  Future<void> addNoteToFirebase(String id, String title, String description) {
    return _$addNoteToFirebaseAsyncAction
        .run(() => super.addNoteToFirebase(id, title, description));
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

  late final _$clearNotesAsyncAction =
      AsyncAction('_NotesStore.clearNotes', context: context);

  @override
  Future<void> clearNotes() {
    return _$clearNotesAsyncAction.run(() => super.clearNotes());
  }

  late final _$togglePinAsyncAction =
      AsyncAction('_NotesStore.togglePin', context: context);

  @override
  Future<void> togglePin(NotesModel note) {
    return _$togglePinAsyncAction.run(() => super.togglePin(note));
  }

  late final _$fetchNoteAsyncAction =
      AsyncAction('_NotesStore.fetchNote', context: context);

  @override
  Future<NotesModel> fetchNote(String noteId) {
    return _$fetchNoteAsyncAction.run(() => super.fetchNote(noteId));
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
searchResultNotes: ${searchResultNotes},
initFireDB: ${initFireDB},
isLoggedin: ${isLoggedin},
current_user: ${current_user},
collectionRef: ${collectionRef}
    ''';
  }
}
