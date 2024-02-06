// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotesStore on _NotesStore, Store {
  late final _$notesAtom = Atom(name: '_NotesStore.notes', context: context);

  @override
  ObservableList<NotesModel> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(ObservableList<NotesModel> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
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

  late final _$getNotesAsyncAction =
      AsyncAction('_NotesStore.getNotes', context: context);

  @override
  Future<void> getNotes() {
    return _$getNotesAsyncAction.run(() => super.getNotes());
  }

  late final _$_NotesStoreActionController =
      ActionController(name: '_NotesStore', context: context);

  @override
  void addNote(NotesModel note) {
    final _$actionInfo =
        _$_NotesStoreActionController.startAction(name: '_NotesStore.addNote');
    try {
      return super.addNote(note);
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeNote(NotesModel note) {
    final _$actionInfo = _$_NotesStoreActionController.startAction(
        name: '_NotesStore.removeNote');
    try {
      return super.removeNote(note);
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notes: ${notes},
initHiveDB: ${initHiveDB}
    ''';
  }
}
