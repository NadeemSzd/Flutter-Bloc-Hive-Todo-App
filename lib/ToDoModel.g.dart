// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ToDoModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<Todo>
{
  @override
  Todo read(BinaryReader reader)
  {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>
    {
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      name: fields[0] as String,
      course: fields[1] as String,
      semester: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.course)
      ..writeByte(2)
      ..write(obj.semester);
  }

  @override
  final typeId = 0;
}
