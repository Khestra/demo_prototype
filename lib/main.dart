import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

bool isValidEmail(String email) {
  final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegExp.hasMatch(email);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'My Demo',
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(title: Text("Prototype")),
          body: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  label: Text('Email'),
                  prefixIcon: Icon(CupertinoIcons.mail),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                contextMenuBuilder: (context, editableTextState) {
                  final TextEditingValue value = editableTextState.textEditingValue;
                  final List<ContextMenuButtonItem> buttonItems = editableTextState.contextMenuButtonItems;
                  if (isValidEmail(value.selection.textInside(value.text))) {
                    buttonItems.insert(
                      0,
                      ContextMenuButtonItem(
                        label: 'Send email',
                        onPressed: () {
                          ContextMenuController.removeAny();
                          // Navigator.of(context).push(_showDialog(context));
                        },
                      ),
                    );
                  }
                  return AdaptiveTextSelectionToolbar.buttonItems(
                    anchors: editableTextState.contextMenuAnchors,
                    buttonItems: buttonItems,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
