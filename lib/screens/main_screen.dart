import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:justnote/models/boxes.dart';
import 'package:justnote/provider.dart';
import 'package:provider/provider.dart';

import '../models/notes_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Boxes.addNoteToBase().listenable(),
        builder: (context, box, _){
          final notes = box.values.toList().cast<NotesModel>();
          return Consumer<NotesProvider>(
            builder: (context, data, _){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(controller: data.titleController,),
                  TextField(controller: data.bodyController,),
                  TextField(controller: data.photoController,),
                  TextField(controller: data.audioController,),
                  ElevatedButton(
                      onPressed: () => data.addNoteToBase(),
                      child: Text('Add')),
                  SizedBox(
                    width: size.width,
                    height: 200,
                    child: ListView.builder(
                      itemCount: box.length,
                        itemBuilder: (context, index){
                          return Row(
                            children: [
                              Text(notes[index].title),
                              Text(notes[index].body),
                              Text(notes[index].photo),
                              Text(notes[index].audio),
                              Text(notes[index].dateTime),
                            ],
                          );
                        }),
                  )
                ],
              );
            },
          );
        },
      )
    );
  }
}
