import 'package:flutter/material.dart';
import 'package:devfest2022/local_storage.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  List listTodo = LocalStorage.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
        actions: [IconButton(
          icon: const Icon(Icons.delete),
          onPressed: (){
            listTodo.clear();
            LocalStorage.add(listTodo);
            setState(() {
            });
          },
        )],
      ),
      body: ListView.builder(
        itemCount: listTodo.length,
        itemBuilder: (BuildContext contex, int index){
          return ListTile(
            leading: Checkbox(
              onChanged: (value){
                listTodo[index]["status"] = !listTodo[index]["status"];
                LocalStorage.add(listTodo);
                setState(() {
                });
              },
              value: listTodo[index]["status"],
            ),
            title: Text(listTodo[index]["todo"],
              style: TextStyle(decoration: listTodo[index]["status"]?TextDecoration.lineThrough:TextDecoration.none)
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (){
                listTodo.removeAt(index);
                LocalStorage.add(listTodo);
                setState(() {
                });
              },
            ),
          );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          String text = "";
          TextEditingController textEditingController = TextEditingController();
          showDialog<String>(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("New TODO"),
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: Icon(Icons.close)),
                  ],
                ),
                content: TextField(
                  controller: textEditingController,
                  onChanged: (value){
                    text = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                    child: Text("Create"),
                    onPressed: (){
                      listTodo.add({
                        "todo": text, "status": false
                      });
                      textEditingController.text = "";
                      LocalStorage.add(listTodo);
                      setState(() {
                      });
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Create',
        child: const Icon(Icons.add),
      )
    );
  }
}
