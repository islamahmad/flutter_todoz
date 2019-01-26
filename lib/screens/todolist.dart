import "package:flutter/material.dart";
import "package:todoz/model/todo.dart";
import "package:todoz/screens/tododetails.dart";
import "package:todoz/util/DbHelper.dart";

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State {
  DbHelper helper = DbHelper(); // will be used to handle DB activities
  List<Todo> todos; // will contain the list of Todos retrived from the DB
  int count = 0; // to hold the number of Todos in the list
  @override
  Widget build(BuildContext context) {
    if (todos == null) {
      todos = List<Todo>();
      getData();
    }
    return Scaffold(
      body: todoListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetial(Todo('', '', 3));
        },
        tooltip: "Add new todo",
        child: new Icon(Icons.add),
      ),
    );
  }

  ListView todoListItems() {
    return ListView.builder(
      itemCount: this.count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.todos[position].priority),
              child: Text(this.todos[position].priority.toString()),
            ),
            title: Text(this.todos[position].title),
            subtitle: Text(this.todos[position].date),
            onTap: () {
              debugPrint(
                  "Tapped on tile " + this.todos[position].id.toString());
              navigateToDetial(this.todos[position]);
            },
          ),
        );
      }, // this property of the list view takes a function that will be iterated for each item in the list
    );
  }

  void getData() {
    final dbFuture = helper
        .initializeDB(); //this returns a future of type DB not the DB itself
    // remember that the singleton  returns THE DB instance of the APP, opens it or creates it
    dbFuture.then((result) {
      final todosFuture = helper.getTodoz();
      todosFuture.then((result) {
        List<Todo> todoList = List<Todo>(); // create a list
        count = result.length;
        for (int i = 0; i < count; i++) {
          todoList.add(Todo.fromObject(
              result[i])); // convert the generic obkect to a todo object
          debugPrint(todoList[i].title.toString());
        }
        setState(() {
          this.todos =
              todoList; // assign the populated list to the property of the class
          this.count = count;
          debugPrint("# Items in the list is " + count.toString());
        });
      });
    });
  }

  // ignore: missing_return
  Color getColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.yellow;
        break;
    }
  }

  void navigateToDetial(Todo todo) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoDetail(todo)),
    );
  }
}
