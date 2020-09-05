
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'ToDoModel.dart';



// Events
class StudentBlocEvents extends Equatable
{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NoEvent extends StudentBlocEvents{}

class AddStudentEvent extends StudentBlocEvents
{
  final Todo todo;
  final BuildContext context;
  AddStudentEvent(this.todo,this.context);
}

class DeleteStudentEvent extends StudentBlocEvents
{
  final int key;
  DeleteStudentEvent(this.key);
}

class UpdateStudentEvent extends StudentBlocEvents
{
  final int key;
  final Todo todo;
  UpdateStudentEvent(this.key,this.todo);
}



// States
class StudentBlocStates extends Equatable
{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitialState extends StudentBlocStates
{
  final Box<Todo> todoBox = Hive.box<Todo>('StudentBox');
}

class ProcessState extends StudentBlocStates{}

class StudentAddedSuccessState extends StudentBlocStates
{
  final Box<Todo> todoBox;
  StudentAddedSuccessState(this.todoBox);
}

class StudentNotAddedState extends StudentBlocStates
{
  final Box<Todo> todoBox;
  StudentNotAddedState(this.todoBox);
}

class StudentDeletedSuccessState extends StudentBlocStates
{
  final Box<Todo> todoBox;
  StudentDeletedSuccessState(this.todoBox);
}

class StudentNotDeletedState extends StudentBlocStates
{
  final Box<Todo> todoBox;
  StudentNotDeletedState(this.todoBox);
}

class StudentUpdatedSuccessState extends StudentBlocStates
{
  final Box<Todo> todoBox;
  StudentUpdatedSuccessState(this.todoBox);
}


// Bloc
class StudentBloc extends Bloc<StudentBlocEvents,StudentBlocStates>
{

  Box<Todo> todoBox;

  StudentBloc(StudentBlocStates initialState) : super(initialState)
  {
    todoBox = Hive.box<Todo>('StudentBox');
  }

  @override
  Stream<StudentBlocStates> mapEventToState(StudentBlocEvents event) async*
  {
    if(event is AddStudentEvent)
      {
        yield ProcessState();
        await Future.delayed(Duration(seconds: 1));
        todoBox.add(event.todo);
        yield StudentAddedSuccessState(todoBox);
        await Future.delayed(Duration(seconds: 2));
      }
    else if(event is DeleteStudentEvent)
      {
        yield ProcessState();
        await Future.delayed(Duration(seconds: 1));
        todoBox.delete(event.key);
        yield StudentDeletedSuccessState(todoBox);
      }
    else if(event is UpdateStudentEvent)
      {
        yield ProcessState();
        await Future.delayed(Duration(seconds: 1));
        todoBox.delete(event.key);
        //todoBox.add(event.todo);
        yield StudentUpdatedSuccessState(todoBox);
      }
  }

}
