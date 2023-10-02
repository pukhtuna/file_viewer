import 'package:file_viewer/util/shared_code.dart';
import 'package:file_viewer/view/view_document.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const CustomText(text: 'Input URL', fontSize: 22)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(controller: urlController),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ViewDocumentScreen(url: urlController.text.trim()),
                    ));
                  },
                  child: const CustomText(text: 'View File', fontSize: 16))
            ],
          ),
        ),
      ),
    );
  }
}
