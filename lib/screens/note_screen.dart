import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:justnote/constants.dart';
import 'package:justnote/provider.dart';
import 'package:provider/provider.dart';
import '../models/boxes.dart';
import '../models/notes_model.dart';
import '../widgets/button_widget.dart';
import 'main_screen.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

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
                  children: [
                    const SizedBox(height: 12,),
                    Container(
                      color: Colors.transparent,
                      height: size.height * 0.08,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonWidget(
                            onTap: () => Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) =>
                                const MainScreen())),
                            icon: Icons.arrow_back,
                          ),
                          const Spacer(),
                          Text(data.reminder == false ? '' : DateFormat('HH:mm d MMM y').format(data.dateTime)),
                          const Spacer(),
                          ButtonWidget(
                            onTap: () => data.setNotificationTime(context),
                            icon: Icons.alarm,
                          ),
                          const SizedBox(width: 30,),
                          ButtonWidget(
                            onTap: () {
                              !data.isEdit
                                  ? data.addNoteToBase(context)
                                  : data.editNoteToBase(
                                  data.editIndex,
                                  data.titleController.text,
                                  data.bodyController.text,
                                  notes[data.editIndex].createTime,
                                  box);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                  const MainScreen()));
                            },
                            icon: Icons.check,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 44,
                        margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: insetDecoration,
                        child: Center(
                          child: TextField(
                            controller: data.titleController,
                            cursorColor: Colors.white,
                            style: kBlackStyle,
                            decoration: InputDecoration(
                                isCollapsed: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent)
                                ),
                                hintText: 'Title',
                                hintStyle: TextStyle(fontSize: 24, color: Colors.white.withOpacity(0.7))
                            ),
                          ),
                        )),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          decoration: insetDecoration,
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: data.bodyController,
                            cursorColor: Colors.white,
                            style: kBlackStyle,
                            decoration: InputDecoration(
                                isCollapsed: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent)
                                ),
                                hintText: 'Description',
                                hintStyle: TextStyle(fontSize: 24, color: Colors.white.withOpacity(0.7))
                            ),
                          )),
                    ),
                    const SizedBox(height: 12,),
                  ],
                );
              },
            );
          },
        )
      ),
    );
  }
}
