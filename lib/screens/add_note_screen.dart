import 'package:flutter/material.dart';
import 'package:justnote/constants.dart';
import 'package:justnote/provider.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kGrey,
      body: SafeArea(
        child: Consumer<NotesProvider>(
          builder: (context, data, _){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(controller: data.titleController,),
                TextField(controller: data.bodyController,),
                ElevatedButton(
                    onPressed: () => data.addNoteToBase(context),
                    child: Text('Add')),
              ],
            );
          },
        ),
      ),
    );
  }
}
