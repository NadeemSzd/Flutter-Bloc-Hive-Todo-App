
import 'package:hive/hive.dart';

part 'ToDoModel.g.dart';

@HiveType(typeId: 0)
class Todo
{
  @HiveField(0)
  String name;

  @HiveField(1)
  String course;

  @HiveField(2)
  int semester;


  Todo({this.name,this.course,this.semester});
}