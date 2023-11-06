import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Todos')),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, indx) {
              return ListTile(
                title: Text(todos[indx].title),
                onTap: () {
                  String message = 'Hello, this is a single line of text!';
                  Map<String, dynamic> data = {
                    'm_message': "this is map messsage",
                    'number': 121,
                  };

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailScreen(),
                        //settings: RouteSettings(arguments: todos[indx]),
                        settings: RouteSettings(
                          arguments: {
                            'data1': todos[indx],
                            'data2': data,
                          },
                        ),
                      ));
                },
              );
            }));
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    // final todo = ModalRoute.of(context)!.settings.arguments as Todo;

    Color textColor = Colors.green;
    bool isClicked = false;

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    dynamic msg1 = args['data1'];
    Map<String, dynamic> receiveMap = args['data2'] as Map<String, dynamic>;
    String msg2 = receiveMap['m_message'];
    int number = receiveMap['number'];
    return Scaffold(
        appBar: AppBar(title: Text(msg1.description)),
        body: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'message1 $msg1 messsage2 $msg2 and number is  $number ',
                style: const TextStyle(color: Colors.black)),
            TextSpan(
              text:
                  'By clicking the ok you are sure about our term and conditions.. ',
              style: TextStyle(color: textColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    textColor = isClicked ? Colors.black : Colors.purple;
                    isClicked = !isClicked;
                  });
                },
            ),
            TextSpan(
                text: 'Term & conditions ',
                style: const TextStyle(
                    color: Colors.blue, fontStyle: FontStyle.italic),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pop(context);
                    _showToast(context);
                  }),
            const TextSpan(
                text: 'Another you can not use our service.. ',
                style: TextStyle(color: Colors.black)),
           
          ]),
        ));
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: const Text('Another toast'),
      action: SnackBarAction(
        label: 'Todo',
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ));
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

class Todo {
  final String title;
  final String description;
  const Todo(this.title, this.description);
}
