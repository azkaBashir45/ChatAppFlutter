import 'package:firebase_app_web/Service/Auth_Service.dart';
import 'package:firebase_app_web/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: deprecated_member_use
  List todos = List();
  String input = "";

  @override
  void initState() {
    super.initState();
    todos.add("item1");
    todos.add("item2");
    todos.add("item3");
  }

  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.black38,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await authClass.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => MyApp()),
                    (route) => false);
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Add TodoList"),
                    content: TextField(
                      onChanged: (String value) {
                        input = value;
                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              todos.add(input);
                            });
                          },
                          color: Colors.blue,
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ))
                    ]);
              });
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(todos[index]),
                child: Card(
                  color: Colors.white60,
                  child: ListTile(
                    title: Text(
                      todos[index],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    trailing: SizedBox(
                      width: 98,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                todos.removeAt(index);
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: () {
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text("Update Todolist"),
                                        content: TextField(
                                          onChanged: (String value) {
                                            input = value;
                                          },
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () {
                                                setState(() {
                                                  todos.add(input);
                                                });
                                              },
                                              color: Colors.blue,
                                              child: Text(
                                                "Update",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))
                                        ]);
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
