// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotesModelAdapter extends TypeAdapter<_NotesModel> {
  @override
  final int typeId = 0;

  @override
  _NotesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotesModel(
      title: fields[0] as String,
      description: fields[1] as String,
      id: fields[2] as String,
      isPinned: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _NotesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.isPinned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotesModel on _NotesModel, Store {
  late final _$titleAtom = Atom(name: '_NotesModel.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_NotesModel.description', context: context);

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$idAtom = Atom(name: '_NotesModel.id', context: context);

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$isPinnedAtom =
      Atom(name: '_NotesModel.isPinned', context: context);

  @override
  bool get isPinned {
    _$isPinnedAtom.reportRead();
    return super.isPinned;
  }

  @override
  set isPinned(bool value) {
    _$isPinnedAtom.reportWrite(value, super.isPinned, () {
      super.isPinned = value;
    });
  }

  late final _$_NotesModelActionController =
      ActionController(name: '_NotesModel', context: context);

  @override
  void setTitle(String value) {
    final _$actionInfo =
        _$_NotesModelActionController.startAction(name: '_NotesModel.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_NotesModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_NotesModelActionController.startAction(
        name: '_NotesModel.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_NotesModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
description: ${description},
id: ${id},
isPinned: ${isPinned}
    ''';
  }
}
