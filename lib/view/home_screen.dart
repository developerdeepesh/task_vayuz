import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_vayuz/view/todo_list.dart';
import 'package:task_vayuz/view_model/todo_view_model.dart';
import 'package:task_vayuz/wdigets/add_dialog.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff0D3257),
            title: const Text('Todo Task'),
            centerTitle: true,
          ),
          body: _getBody(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff0D3257),
            child: const Icon(Icons.add),
            onPressed: () {
              addItem(viewModel);
            },
          ),
        );
      },
    );
  }

  Widget _getBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodoListScreen(isFrom: "Today",)),
                );
              },
              child: button("Today")),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodoListScreen(isFrom: "Tomorrow",)),
                );
              },
              child: button("Tomorrow")),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TodoListScreen(isFrom: "Upcoming",)),
                  );

              },
              child: button("Upcoming")),
        ],
      ),
    );
  }

  Widget button(String text) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff0D3257)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 15),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  void addItem(TodoViewModel viewModel) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(0),
            elevation: 0.0,
            backgroundColor: Colors.white24,
            child: AddDialog(),
          );
        });
  }

}
