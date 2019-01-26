import 'package:flutter/material.dart';
import 'package:todoz/model/todo.dart';
import 'package:todoz/util/DbHelper.dart';
import 'package:todoz/screens/todolist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<Todo> todos = List<Todo>();  //create an empty list of todos type
    // DbHelper helper = DbHelper(); // create the DB helper at the begining of the application creation, which will return the singleton object using the internal constructor
    // //initialize connection to DB, and upon completion call getTodoz function, then put them in the list called todos
    // helper.initializeDB().then(
    //   (result) => helper.getTodoz().then(
    //     (result) => todos=result
    //     )
    //   );
    // DateTime today = DateTime.now(); // get time stamp
    // Todo newTodo = Todo("Buy stuff2 ", today.toString(), 1,"Some 2 description here");
    // helper.insertTodo(newTodo);

    return MaterialApp(
      title: 'Todoz',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'todoZ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: TodoList(),
    );
  }
}
