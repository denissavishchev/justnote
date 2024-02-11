import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:justnote/constants.dart';
import 'package:justnote/models/boxes.dart';
import 'package:justnote/provider.dart';
import 'package:provider/provider.dart';
import '../models/notes_model.dart';
import '../widgets/list_item_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kGrey,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Boxes.addNoteToBase().listenable(),
          builder: (context, box, _){
            final notes = box.values.toList().cast<NotesModel>();
            return Consumer<NotesProvider>(
              builder: (context, data, _){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      height: size.height * 0.08,
                    ),
                    // TextField(controller: data.titleController,),
                    // TextField(controller: data.bodyController,),
                    // ElevatedButton(
                    //     onPressed: () => data.addNoteToBase(),
                    //     child: Text('Add')),
                    const ListItemWidget(),
                    Container(
                      color: Colors.white,
                      height: size.height * 0.08,
                    )
                  ],
                );
              },
            );
          },
        ),
      )
    );
  }
}


