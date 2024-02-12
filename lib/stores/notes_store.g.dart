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

  late final _$initHiveDBAtom =
      Atom(name: '_NotesStore.initHiveDB', context: context);

  @override
  bool get initHiveDB {
    _$initHiveDBAtom.reportRead();
    return super.initHiveDB;
  }

  @override
  set initHiveDB(bool value) {
    _$initHiveDBAtom.reportWrite(value, super.initHiveDB, () {
      super.initHiveDB = value;
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

  late final _$initAsyncAction =
      AsyncAction('_NotesStore.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$getBoxAsyncAction =
      AsyncAction('_NotesStore.getBox', context: context);

  @override
  Future<void> getBox() {
    return _$getBoxAsyncAction.run(() => super.getBox());
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

  late final _$_NotesStoreActionController =
      ActionController(name: '_NotesStore', context: context);

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
  void togglePin(NotesModel note) {
    final _$actionInfo = _$_NotesStoreActionController.startAction(
        name: '_NotesStore.togglePin');
    try {
      return super.togglePin(note);
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  NotesModel fetchNote(String noteId) {
    final _$actionInfo = _$_NotesStoreActionController.startAction(
        name: '_NotesStore.fetchNote');
    try {
      return super.fetchNote(noteId);
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notes: ${notes},
pinnedNotes: ${pinnedNotes},
initHiveDB: ${initHiveDB},
box: ${box}
    ''';
  }
}
