import 'package:flutter/material.dart';
import 'package:todo_app/database/db_helper.dart';
import 'package:todo_app/models/TaskModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  Future<List<Task>> tasks;
  DBHelper dbHelper;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    _incrementCounter();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      tasks = dbHelper.getTasks();
    });
  }

  list(List<Task> tasks) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
              child: Row(
            children: <Widget>[
              Text(tasks[index].description),
              Text(tasks[index].title),
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder(
              future: tasks,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return list(snapshot.data);
                }
                if (snapshot.data.length == 0) {
                  return Text('Data is empty');
                }
                return CircularProgressIndicator();
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dbHelper.insertTask(Task(
              description: _counter.toString(),
              title: 'hi',
              dueToDay: DateTime.now().toString()));
          _incrementCounter();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
