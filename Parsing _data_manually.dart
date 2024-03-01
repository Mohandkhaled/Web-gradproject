import 'package:flutter/material.dart';
//import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log Parsing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> fileList = [];

 
  @override
  Widget build(BuildContext context) {
    var pickFiles;
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Upload and List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard),
            onPressed: () {
              // Navigate to the dashboard page
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: (pickFiles),
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Upload File'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: fileList.isEmpty
                    ? const Center(
                        child: Text(
                          'No files uploaded yet',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: fileList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.file_present),
                            title: Text(
                              fileList[index].split('/').last,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
