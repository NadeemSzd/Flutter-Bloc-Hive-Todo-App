import 'package:bloc_hive_example/StudentBloc.dart';
import 'package:bloc_hive_example/ToDoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'ToDoModel.dart';



class Home extends StatefulWidget
{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
{

  final key = GlobalKey<FormState>();

  StudentBloc studentBloc;

  //Box<Todo> todoBox;

  TextEditingController nameController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController semesterController = TextEditingController();

  bool validateAndSave()
  {
    final formState = key.currentState;
    if(formState.validate())
      {
        formState.save();
        return true;
      }
    return false;
  }

  @override
  void initState()
  {
    super.initState();

   // todoBox = Hive.box<Todo>('StudentBox');
    studentBloc = BlocProvider.of<StudentBloc>(context);
  }

  @override
  void dispose()
  {
    super.dispose();
    studentBloc.close();
  }

  @override
  Widget build(BuildContext context)
  {

    return Scaffold(

      appBar: AppBar(
        title: Text('Hive DataBase'),
        centerTitle: true,
        elevation: 0,
      ),

      backgroundColor: Theme.of(context).primaryColor,

      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),
          color: Colors.white,
        ),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15),
          children:
          [

            Container(
              child: Column(
                children:
                [

                  Form(
                    key: key,
                    child: Column(
                      children:
                      [

                        TextFormField(
                          controller: nameController,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: 'Enter Student Name',
                              hintStyle: TextStyle(fontSize: 18),
                              errorStyle: TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20),
                              fillColor: Colors.brown,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.pinkAccent)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.redAccent)
                              )
                          ),
                          validator: (value)
                          {
                            return value.isEmpty ? 'Student Name Required!' : null;
                          },
                          onSaved: (value)
                          {
                           // name = value.toString();
                          },
                        ),

                        SizedBox(height: 8,),

                        TextFormField(
                          controller: courseController,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: 'Enter Course Name',
                              hintStyle: TextStyle(fontSize: 18),
                              errorStyle: TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20),
                              fillColor: Colors.brown,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.pinkAccent)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.redAccent)
                              )
                          ),
                          validator: (value)
                          {
                            return value.isEmpty ? 'Course Name Required!' : null;
                          },
                          onSaved: (value)
                          {
                            // name = value.toString();
                          },
                        ),

                        SizedBox(height: 8,),

                        TextFormField(
                          controller: semesterController,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: 'Enter Semester',
                              hintStyle: TextStyle(fontSize: 18),
                              errorStyle: TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20),
                              fillColor: Colors.brown,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: Colors.pinkAccent)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.redAccent)
                              )
                          ),
                          validator: (value)
                          {
                            return value.isEmpty ? 'Semester Required!' : null;
                          },
                          onSaved: (value)
                          {
                            // name = value.toString();
                          },
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: 10,),

                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text('Save',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.white),),
                      color: Colors.purpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: ()
                      {
                        if(validateAndSave())
                        {
                          String name = nameController.text;
                          String course = courseController.text;
                          int semester = int.parse(semesterController.text);

                          nameController.clear();
                          courseController.clear();
                          semesterController.clear();

                          Todo todo = new Todo(name: name,course: course,semester: semester);

                          studentBloc.add(AddStudentEvent(todo,context));
                          //todoBox.add(todo);
                        }
                      },
                    ),
                  ),

                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 25),
              height: MediaQuery.of(context).size.height * 0.52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).primaryColor,
              ),
              child: BlocBuilder<StudentBloc,StudentBlocStates>(
                builder: (context,state)
                {
                  if(state is InitialState)
                    {
                      return showStudents(state.todoBox);
                    }
                  else if(state is ProcessState)
                    {
                      return Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.yellowAccent));
                    }
                  else if(state is StudentAddedSuccessState)
                    {
                      /*final snackbar = SnackBar(
                        content: Text('Student Added Successfully...'),
                      );
                      Scaffold.of(context).showSnackBar(snackbar);*/
                      return showStudents(state.todoBox);
                    }
                  else if(state is StudentNotAddedState)
                    {
                      // show snackbar
                    }
                  else if(state is StudentDeletedSuccessState)
                    {
                      return showStudents(state.todoBox);
                    }
                  else if(state is StudentNotDeletedState)
                    {
                      // show snackbar
                    }
                  else if(state is StudentUpdatedSuccessState)
                    {
                      return showStudents(state.todoBox);
                    }
                  return null;
                },
              ),
            )

          ],
        ),
      ),

    );
  }
  
  Widget showStudents(Box<Todo> todoBox)
  {
    return ValueListenableBuilder(
      valueListenable: todoBox.listenable(),
      builder: (BuildContext context,Box<Todo> todoDataBox,_)
      {

        List<int> keys = todoDataBox.keys.cast<int>().toList();

        return keys.length == 0
            ? Center(child: Text('No Student Exists!',style: TextStyle(color: Colors.white,fontSize: 17),),)
            : ListView.builder(
               itemBuilder: (context,index)
               {

                final  key = keys[index];
                Todo todo = todoDataBox.get(key);

                return Container(
                 alignment: Alignment.center,
                 height: 50,
                 margin: EdgeInsets.only(left: 5,right:5 ,top: 4,bottom: 4),
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.blueGrey,
                  border: Border.all(color: Colors.yellowAccent,width: 1.5)
                 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:
                              [
                                Text(todo.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ],
                            ),

                            SizedBox(height: 3,),

                            Row(
                              children:
                              [

                                Text(todo.course,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                SizedBox(width: 5,),
                                Text('|',style: TextStyle(color: Colors.white),),
                                SizedBox(width: 5,),
                                Text('Semester : ',style: TextStyle(color: Colors.white),),
                                SizedBox(width: 5,),
                                Text(todo.semester.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                              ],
                            ),

                          ],
                        ),
                      ),
                      Row(
                        children:
                        [

                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: ()
                            {
                              nameController.text = todo.name;
                              courseController.text = todo.course;
                              semesterController.text = todo.semester.toString();

                              Todo todo1 = Todo(name: nameController.text,
                                                course: courseController.text,
                                                semester: int.parse(semesterController.text));

                              print('Update index  : ' + index.toString());
                              studentBloc.add(UpdateStudentEvent(key,todo1));
                            },
                          ),

                          SizedBox(width: 5,),

                          IconButton(
                            icon: Icon(Icons.delete_forever),
                            color: Colors.white,
                            onPressed: ()
                            {
                              studentBloc.add(DeleteStudentEvent(key));
                            },
                          ),

                        ],
                      ),
                    ],
                  ),
            );

          },
          itemCount: keys.length,
        );
      },
    );
  }
  
}

/*ValueListenableBuilder(
                    valueListenable: todoBox.listenable(),
                    builder: (BuildContext context,Box<Todo> todoDataBox,_)
                    {

                      List<int> keys = todoDataBox.keys.cast<int>().toList();

                      return ListView.builder(
                        itemBuilder: (context,index)
                        {

                          final  key = keys[index];
                          Todo todo = todoDataBox.get(key);

                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 5,right:5 ,top: 6.2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.blueGrey,
                                border: Border.all(color: Colors.yellowAccent,width: 1.5)
                            ),
                            child: ListTile(
                              title: Text(todo.name,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                              subtitle: Text(todo.course,style: TextStyle(fontSize: 15,color: Colors.white),),
                              trailing: IconButton(icon: Icon(Icons.delete_forever,size: 30,color: Colors.white),onPressed: ()
                              {
                                studentBloc.add(DeleteStudentEvent(key));
                                // todoBox.delete(key);
                              },),
                            ),
                          );

                        },
                        itemCount: keys.length,
                      );
                    },
                  )*/



