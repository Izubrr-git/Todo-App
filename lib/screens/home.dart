import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/constants/colors.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../model/todo.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/todo_item.dart';
import '../services/task_api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  final _taskApiService = TaskApiService();
  bool _isAvatarHovered = false;

  List<ToDo> _taskList = [];

  @override
  void initState() {
    super.initState();
    _taskList = todoList;
  }

  @override
  Widget build(BuildContext context) {
    _loadTasks();
    return Scaffold(
      backgroundColor: tdBlue,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              children: [
                Center(
                  child: SimpleShadow(
                    sigma: 7,
                    child: Image(
                      width: 120.0,
                      height: 120.0,
                      image: Image.asset('assets/images/logo2.png').image,
                    ), // Default: 2
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text('To-Do List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.black54,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        )),
                    FloatingActionButton(
                      elevation: 10,
                      onPressed: () {
                        showAddTaskDialog(context, _taskApiService.addTask);
                      },
                      backgroundColor: tdGreen,
                      child: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: tdBGColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0, 10),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        final todo = todoList[todoList.length - 1 - index];
                        return TodoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadTasks() async {
    final scaffoldMessengerContext = ScaffoldMessenger.of(context);
    try {
      final todos = await _taskApiService.getTaskList();
      setState(() {
        _taskList = todos;
      });
    } catch (e) {
      scaffoldMessengerContext.showSnackBar(
        const SnackBar(content: Text('Ошибка при загрузке задач')),
      );
    }
  }

  Future<void> _deleteToDoItem(String id) async {
    final scaffoldMessengerContext = ScaffoldMessenger.of(context);
    try {
      bool isDeleted = await _taskApiService.deleteTask(id);
      if (isDeleted) {
        setState(() {
          _taskList.removeWhere((item) => item.id == id);
        });
        scaffoldMessengerContext.showSnackBar(
          const SnackBar(content: Text('Задача успешно удалена')),
        );
      }
    } catch (e) {
      // Обработка ошибок удаления
      if (kDebugMode) {
        print('Error deleting task: $e');
      }
      scaffoldMessengerContext.showSnackBar(
        const SnackBar(content: Text('Ошибка при удалении задачи')),
      );
    }
  }

  Future<void> _handleToDoChange(ToDo todo) async {
    final scaffoldMessengerContext = ScaffoldMessenger.of(context);
    try {
      ToDo updatedTodo = await _taskApiService.updateTask(todo);
      setState(() {
        int index = _taskList.indexWhere((item) => item.id == updatedTodo.id);
        if (index != -1) {
          _taskList[index] = updatedTodo;
        }
      });
      scaffoldMessengerContext.showSnackBar(
        const SnackBar(content: Text('Задача успешно обновлена')),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error updating task: $e');
      }
      scaffoldMessengerContext.showSnackBar(
        const SnackBar(content: Text('Ошибка при обновлении задачи')),
      );
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBlue,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
            onHover: (event) {
              setState(() {
                if (event) {
                  _isAvatarHovered = true;
                } else {
                  _isAvatarHovered = false;
                }
              });
            },
            onTap: () {
              //TODO переход на страницу профиля или выпадающий список
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                    'assets/images/default_avatar.jpg',
                    color: _isAvatarHovered ? Colors.grey.shade300 : null, // добавляем эффект наведения
                    colorBlendMode: _isAvatarHovered ? BlendMode.modulate : null,
                  )),
            ),
          ),
          IconButton(icon: const Icon(Icons.menu, color: Colors.white, size: 30), onPressed: () {
            // TODO Темы оформления
            // TODO Синхронизация с другими устройствами
            // TODO Экспорт/импорт списков задач
            // TODO Помощь или руководство пользователя
            // TODO О приложении / Информация о версии
          }),
        ]),
      ),
    );
  }
}
